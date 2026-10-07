#!/usr/bin/env bash
# Spec runner: wraps plenary's busted harness with a suite-wide summary.
#
#   bash tests/run.sh                         # every tests/*_spec.lua
#   bash tests/run.sh tests/foldtext_spec.lua # just these files
#
# Plenary prints one Success/Failed/Errors block per file and no overall total,
# and PlenaryBustedDirectory interleaves the parallel jobs' output, so a failure
# can't be reliably traced back to its file. Instead this runs each spec in its
# own headless nvim (in parallel, as plenary does), captures each file's output
# separately, prints them in a stable order, then adds:
#
#   - a totals line and the failing tests repeated at the bottom
#   - ANSI colors stripped when stdout isn't a terminal (CI logs, pipes) or
#     NO_COLOR is set
#   - a markdown summary appended to $GITHUB_STEP_SUMMARY when set (GitHub
#     Actions sets it), so failures show on the run page without the raw log
#
# Exit status is 0 only if every file exited 0, else 1. Per-file timeout is
# SPEC_TIMEOUT seconds (default 120).
set -uo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
init="$root/tests/minimal_init.lua"
timeout_s=${SPEC_TIMEOUT:-120}

if (($# > 0)); then
  # Absolutize against the caller's cwd: specs run with cwd = repo root.
  files=()
  for f in "$@"; do
    [[ $f == /* ]] || f="$PWD/$f"
    files+=("$f")
  done
else
  files=("$root"/tests/*_spec.lua)
fi

color=1
if [[ ! -t 1 || -n ${NO_COLOR:-} ]]; then
  color=0
fi

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

# Launch every spec at once; each writes <i>.out and <i>.rc.
for i in "${!files[@]}"; do
  (
    cd "$root" || exit 2
    timeout "$timeout_s" nvim --headless --noplugin -u "$init" \
      -c "lua require('plenary.busted').run([[${files[$i]}]])" >"$work/$i.out" 2>&1
    echo $? >"$work/$i.rc"
  ) &
done
wait

# Plenary emits CRLF line endings and hard-coded ANSI colors.
clean() {
  if ((color)); then
    tr -d '\r'
  else
    tr -d '\r' | sed -E 's/\x1b\[[0-9;]*m//g'
  fi
}
plain() {
  tr -d '\r' | sed -E 's/\x1b\[[0-9;]*m//g'
}
# count <label> <file>: the number after plenary's "Success:"-style label.
count() {
  awk -v label="$1" -F'\t' 'index($1, label) == 1 { n = $2 + 0 } END { print n + 0 }' "$2"
}

pass=0 fail=0 errs=0 bad_files=0
failures=() # "file: test description" / "file: <problem>"

for i in "${!files[@]}"; do
  rel=${files[$i]#"$root"/}
  out="$work/$i.out"
  rc=$(cat "$work/$i.rc")

  clean <"$out"
  plain <"$out" >"$out.plain"

  p=$(count "Success:" "$out.plain")
  f=$(count "Failed :" "$out.plain")
  e=$(count "Errors :" "$out.plain")
  pass=$((pass + p)) fail=$((fail + f)) errs=$((errs + e))

  while IFS= read -r name; do
    failures+=("$rel: $name")
  done < <(awk -F'\t' '$1 == "Fail" && $2 == "||" { print $3 }' "$out.plain")

  # File-level problems that produce no per-test Fail line.
  if ((rc != 0)); then
    bad_files=$((bad_files + 1))
    if ((rc == 124)); then
      failures+=("$rel: timed out after ${timeout_s}s")
    elif grep -q "FAILED TO LOAD FILE" "$out.plain"; then
      failures+=("$rel: failed to load (syntax or top-level error)")
    elif ((e > 0)); then
      failures+=("$rel: $e error(s) outside a test (e.g. in a describe body)")
    elif ((f == 0)); then
      failures+=("$rel: exited $rc with no failing test reported")
    fi
  fi
done

summary="$pass passed, $fail failed, $errs errors (${#files[@]} files)"

red=$'\e[31m' green=$'\e[32m' reset=$'\e[0m'
if ((!color)); then
  red='' green='' reset=''
fi

echo
echo "========================================"
if ((bad_files == 0)); then
  echo "${green}${summary}${reset}"
else
  echo "${red}${summary}${reset}"
  echo
  echo "Failures:"
  for line in "${failures[@]}"; do
    echo "  - $line"
  done
fi

if [[ -n ${GITHUB_STEP_SUMMARY:-} ]]; then
  {
    if ((bad_files == 0)); then
      echo "### ✅ Specs: $summary"
    else
      echo "### ❌ Specs: $summary"
      echo
      for line in "${failures[@]}"; do
        echo "- \`${line%%: *}\`: ${line#*: }"
      done
    fi
  } >>"$GITHUB_STEP_SUMMARY"
fi

((bad_files == 0))
