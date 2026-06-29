#!/usr/bin/env bash
#
# Headless lua-language-server type-check, for `make lint-types` / CI.
#
# lua_ls is NOT a linter the way luacheck is -- it's the type-aware analyzer that
# powers editor diagnostics (redundant-parameter, missing-fields, cast-local-type,
# undefined-doc-name, ...). luacheck and the busted suite never see those, so
# without this they only ever surface live in an editor and silently accumulate.
# This brings them into the automated pipeline.
#
# In the editor, lazydev injects the type library (the nvim runtime + every
# installed plugin) -- which is why .luarc.json on disk carries no library paths.
# Headless there's no lazydev, so we resolve those paths from nvim here and hand
# lua_ls a config that merges them with the committed .luarc.json. Nothing is
# hardcoded, so this stays portable across machines.
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
cd "$root"

# 1. Locate lua-language-server: $LUALS, then $PATH, then the Mason install that
#    most Neovim setups use.
luals="${LUALS:-}"
if [ -z "$luals" ]; then
  if command -v lua-language-server >/dev/null 2>&1; then
    luals=lua-language-server
  elif [ -x "$HOME/.local/share/nvim/mason/bin/lua-language-server" ]; then
    luals="$HOME/.local/share/nvim/mason/bin/lua-language-server"
  else
    echo "lua-language-server not found. Install it (e.g. :MasonInstall lua-language-server)" >&2
    echo "or point LUALS at the binary: make lint-types LUALS=/path/to/lua-language-server" >&2
    exit 127
  fi
fi
# Validate whatever we resolved (covers an explicit LUALS pointing at a bad path,
# which would otherwise sail through and report a false "no diagnostics").
if ! command -v "$luals" >/dev/null 2>&1; then
  echo "lua-language-server not executable: $luals" >&2
  exit 127
fi

# 2. Resolve the type library from nvim itself (portable; no hardcoded paths).
runtime=$(nvim --headless --noplugin -u NONE +'lua io.write(vim.env.VIMRUNTIME)' +q 2>/dev/null)
lazy=$(nvim --headless --noplugin -u NONE +'lua io.write(vim.fn.stdpath("data").."/lazy")' +q 2>/dev/null)

# 3. Merge the committed .luarc.json (globals, etc.) with the resolved library and
#    the vendored-tree excludes, into a throwaway config.
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
python3 - "$runtime" "$lazy" "$work/luarc.json" <<'PY'
import json, sys
runtime, lazy, out = sys.argv[1:4]
cfg = json.load(open(".luarc.json"))
cfg["Lua.workspace.library"] = [runtime + "/lua", lazy]
cfg["Lua.workspace.checkThirdParty"] = False
# Don't diagnose vendored/tooling trees (mirrors .luacheckrc / markdownlint ignores).
cfg["Lua.workspace.ignoreDir"] = [".tests-deps", ".lua", ".luarocks"]
json.dump(cfg, open(out, "w"), indent=2)
PY

# 4. Check the whole project at >= Warning, then gate on lua_ls's own reported
#    problem COUNT -- the only reliable signal. --check exits 0 even WITH findings,
#    so the exit code is useless; and the machine-readable report (check.json)
#    lands in a version-dependent place (some versions don't even create the
#    --logpath dir), so "is check.json present" is unreliable too -- that combo is
#    what produced a false "no diagnostics" against a run that found 9 problems.
#    Pre-create the log dir, parse the count from lua_ls's summary, and treat
#    check.json as best-effort detail wherever it ends up.
mkdir -p "$work/log"
set +e
out=$("$luals" --check "$root" --configpath="$work/luarc.json" \
  --checklevel=Warning --check_out_path="$work/check.json" --logpath="$work/log" 2>&1)
set -e

# Require lua_ls's completion marker; absent it, lua_ls crashed/early-exited and
# we must fail loudly rather than report a false 'clean'.
summary=$(printf '%s' "$out" | tr '\r' '\n' | grep -iE "Diagnosis complete" | tail -1)
if [ -z "$summary" ]; then
  echo "lua-language-server did not complete a check -- failing rather than" >&2
  echo "reporting a false 'clean'. Its output was:" >&2
  printf '%s\n' "$out" | tr '\r' '\n' | tail -20 >&2
  exit 2
fi

# "Diagnosis completed, no problems found" -> 0; "... N problems found" -> N.
if printf '%s' "$summary" | grep -qi "no problem"; then
  count=0
else
  count=$(printf '%s' "$summary" | grep -oiE "[0-9]+[[:space:]]+problem" | grep -oE "[0-9]+" | head -1)
  count=${count:-0}
fi

if [ "$count" -eq 0 ]; then
  echo "lua-language-server: no diagnostics ($summary)"
  exit 0
fi

# Findings exist -> the gate fails. List them from the report. --check_out_path
# pins it to $work/check.json across versions; the fallbacks (the path lua_ls may
# name, then anything under the temp dir) just guard against future changes.
report="$work/check.json"
[ -s "$report" ] || report=$(printf '%s' "$out" | tr '\r' '\n' | sed -nE 's/.*see (.*check\.json).*/\1/p' | tail -1)
{ [ -n "$report" ] && [ -s "$report" ]; } || report=$(find "$work" -name 'check*.json' -type f 2>/dev/null | head -1)

if [ -n "$report" ] && [ -s "$report" ] && [ "$(cat "$report")" != "{}" ]; then
  python3 - "$report" "$root" <<'PY'
import json, sys
data = json.load(open(sys.argv[1]))
root = sys.argv[2].rstrip("/") + "/"
for uri, probs in sorted(data.items()):
    path = uri.replace("file://", "").replace(root, "")
    for p in sorted(probs, key=lambda x: x["range"]["start"]["line"]):
        ln = p["range"]["start"]["line"] + 1
        print(f"{path}:{ln} [{p['code']}] {p['message'].splitlines()[0]}")
PY
else
  echo "(could not locate lua_ls's check.json to itemize; summary + version:)" >&2
  echo "  $summary" >&2
  echo "  lua_ls $("$luals" --version 2>/dev/null | head -1)" >&2
fi
echo "lua-language-server: $count diagnostic(s)" >&2
exit 1
