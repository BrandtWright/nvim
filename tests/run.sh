#!/usr/bin/env bash
# Headless test runner. Usage:
#   tests/run.sh                 # run every *_spec.lua under tests/
#   tests/run.sh tests/fs_spec.lua   # run a single spec
set -euo pipefail

cd "$(dirname "$0")/.."

INIT="tests/minimal_init.lua"
TARGET="${1:-tests/}"

if [[ "$TARGET" == *_spec.lua ]]; then
  CMD="PlenaryBustedFile $TARGET"
else
  CMD="PlenaryBustedDirectory $TARGET { minimal_init = '$INIT' }"
fi

nvim --headless --noplugin -u "$INIT" -c "$CMD"
