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

# 4. Check the whole project at >= Warning. --check writes findings to check.json
#    and exits 0 even WITH findings, so the exit code can't drive the gate. But a
#    crash / early-exit also "succeeds" silently -- so we require lua_ls's own
#    completion marker ("Diagnosis complete[d] ...") as proof it actually ran.
#    Without that check a broken run looks identical to a clean one and the gate
#    lies green (which is exactly how a false "no diagnostics" slipped through).
set +e
out=$("$luals" --check "$root" --configpath="$work/luarc.json" \
  --checklevel=Warning --logpath="$work/log" 2>&1)
set -e

if ! printf '%s' "$out" | tr '\r' '\n' | grep -q "Diagnosis complete"; then
  echo "lua-language-server did not complete a check -- failing rather than" >&2
  echo "reporting a false 'clean'. Its output was:" >&2
  printf '%s\n' "$out" | tr '\r' '\n' | tail -20 >&2
  exit 2
fi

report="$work/log/check.json"
if [ -s "$report" ] && [ "$(cat "$report")" != "{}" ]; then
  python3 - "$report" "$root" <<'PY'
import json, sys
data = json.load(open(sys.argv[1]))
root = sys.argv[2].rstrip("/") + "/"
total = 0
for uri, probs in sorted(data.items()):
    path = uri.replace("file://", "").replace(root, "")
    for p in sorted(probs, key=lambda x: x["range"]["start"]["line"]):
        total += 1
        ln = p["range"]["start"]["line"] + 1
        print(f"{path}:{ln} [{p['code']}] {p['message'].splitlines()[0]}")
print(f"\nlua-language-server: {total} diagnostic(s)", file=sys.stderr)
PY
  exit 1
fi

# Echo lua_ls's own completion line so a green result visibly proves it ran.
printf '%s\n' "$out" | tr '\r' '\n' | grep "Diagnosis complete" | tail -1
echo "lua-language-server: no diagnostics"
