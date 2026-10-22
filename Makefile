# Test harness for this Neovim config (plenary busted, headless).
#
#   make test                          # run the whole suite
#   make test FILE=tests/foldtext_spec.lua   # run a single spec file
#   make test FILE="tests/a_spec.lua tests/b_spec.lua"   # or several
#   make deps                          # clone the pinned test deps (plenary)
#   make clean-deps                    # remove the cloned test deps
#   make lint                          # all linters: luacheck, markdownlint, lint-types
#   make lint-types                    # just the headless lua-language-server type-check
#   make format                        # rewrite files: stylua, markdownlint --fix
#   make format-check                  # fail on unformatted files; changes nothing
#   make check                         # format-check + lint + test: what CI runs
#                                      # (make -k check: keep going past failures)
#
# `make test` and luacheck are NOT type checkers; lint-types runs lua_ls (the
# analyzer behind editor diagnostics) headless so type-level findings -- missing
# fields, redundant params, bad @-annotations -- are caught in the pipeline
# instead of only live in an editor. It needs plugins installed (lazydev's type
# library) for full fidelity; see tests/luals-check.sh.
#
# The specs need only plenary. It's cloned into the gitignored .tests-deps/ and
# pinned to a known-good commit for reproducibility. Keep PLENARY_REF in sync
# with the plenary entry in your local (gitignored) lazy-lock.json; bump it when
# you intentionally update plenary.

DEPS        := .tests-deps
PLENARY     := $(DEPS)/plenary.nvim
PLENARY_URL := https://github.com/nvim-lua/plenary.nvim
PLENARY_REF := 74b06c6c75e4eeb3108ec01852001636d85a932b
FILE        ?=
LUALS       ?=
STYLUA      ?=

# Tool versions CI pins (.github/workflows/ci.yml); keep these in sync with it.
STYLUA_VERSION       := 2.5.2
MARKDOWNLINT_VERSION := 0.22.1

.PHONY: test deps clean-deps lint lint-types format format-check check

# tests/run.sh runs each spec in its own headless nvim and adds a suite-wide
# summary (and a GitHub job summary in CI); see the script header.
test: deps
	@bash tests/run.sh $(FILE)

# Clone + pin plenary on first use. The directory target makes this idempotent:
# it's skipped once .tests-deps/plenary.nvim exists.
deps: $(PLENARY)
$(PLENARY):
	@echo "Cloning plenary.nvim @ $(PLENARY_REF) into $(DEPS)/ ..."
	@git clone --quiet --filter=blob:none $(PLENARY_URL) $(PLENARY)
	@git -C $(PLENARY) checkout --quiet $(PLENARY_REF)

clean-deps:
	rm -rf $(DEPS)

# Headless lua-language-server check. Resolves the type library from nvim, so it
# needs nvim + plugins installed (and lua_ls on PATH, via LUALS=, or from Mason).
# Invoked via `bash` (not directly) so it runs even where the executable bit was
# dropped on checkout (e.g. core.fileMode=false); the script needs bash anyway.
lint-types:
	@LUALS="$(LUALS)" bash tests/luals-check.sh

# Grouped by action, not by tool: adding a linter or formatter means adding a
# line here, not a new target. Each group runs every tool even after one fails
# (so one run shows all problems), then fails if any did.
#
# markdownlint-cli2 is both: a linter here, and a fixer under format. Its globs
# and ignores live in .markdownlint-cli2.yaml, so the bare invocation matches CI.
MARKDOWNLINT := npx --yes markdownlint-cli2@$(MARKDOWNLINT_VERSION)

lint:
	@status=0; \
	luacheck . || status=1; \
	$(MARKDOWNLINT) || status=1; \
	$(MAKE) --no-print-directory lint-types || status=1; \
	exit $$status

# stylua from STYLUA=, then $PATH, then Mason (same lookup as tests/luals-check.sh).
STYLUA_BIN = $(or $(STYLUA),$(shell command -v stylua 2>/dev/null),$(wildcard $(HOME)/.local/share/nvim/mason/bin/stylua))

# Fails clearly when stylua is missing, and warns (without failing) when it
# isn't the version CI pins: formatting can shift between releases, so a local
# pass could otherwise still fail in CI.
define require_stylua
	@if [ -z "$(STYLUA_BIN)" ]; then \
	  echo "stylua not found. Install it (e.g. :MasonInstall stylua)" >&2; \
	  echo "or point STYLUA at the binary: make $@ STYLUA=/path/to/stylua" >&2; \
	  exit 127; \
	fi; \
	if ! command -v "$(STYLUA_BIN)" >/dev/null 2>&1; then \
	  echo "stylua not executable: $(STYLUA_BIN)" >&2; \
	  exit 127; \
	fi; \
	version=$$("$(STYLUA_BIN)" --version | awk '{print $$2}'); \
	if [ "$$version" != "$(STYLUA_VERSION)" ]; then \
	  echo "warning: stylua $$version, but CI pins $(STYLUA_VERSION)" >&2; \
	fi
endef

# Exits non-zero if markdownlint finds problems it can't fix itself.
format:
	$(require_stylua)
	@status=0; \
	"$(STYLUA_BIN)" . || status=1; \
	$(MARKDOWNLINT) --fix || status=1; \
	exit $$status

# Only stylua: markdownlint's fixable style problems already fail `make lint`.
format-check:
	$(require_stylua)
	@"$(STYLUA_BIN)" --check .

# Every check CI runs, fastest group first, stopping at the first failing group.
check: format-check lint test
