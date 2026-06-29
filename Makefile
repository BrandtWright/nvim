# Test harness for this Neovim config (plenary busted, headless).
#
#   make test                          # run the whole suite
#   make test FILE=tests/foldtext_spec.lua   # run a single spec file
#   make deps                          # clone the pinned test deps (plenary)
#   make clean-deps                    # remove the cloned test deps
#
# The specs need only plenary. It's cloned into the gitignored .tests-deps/ and
# pinned to a known-good commit for reproducibility. Keep PLENARY_REF in sync
# with the plenary entry in your local (gitignored) lazy-lock.json; bump it when
# you intentionally update plenary.

DEPS        := .tests-deps
PLENARY     := $(DEPS)/plenary.nvim
PLENARY_URL := https://github.com/nvim-lua/plenary.nvim
PLENARY_REF := 74b06c6c75e4eeb3108ec01852001636d85a932b
INIT        := tests/minimal_init.lua
FILE        ?=

.PHONY: test deps clean-deps

test: deps
ifeq ($(strip $(FILE)),)
	nvim --headless --noplugin -u $(INIT) \
	  -c "PlenaryBustedDirectory tests/ { minimal_init = '$(INIT)' }"
else
	nvim --headless --noplugin -u $(INIT) \
	  -c "lua require('plenary.busted').run(vim.fn.expand('$(FILE)'))"
endif

# Clone + pin plenary on first use. The directory target makes this idempotent:
# it's skipped once .tests-deps/plenary.nvim exists.
deps: $(PLENARY)
$(PLENARY):
	@echo "Cloning plenary.nvim @ $(PLENARY_REF) into $(DEPS)/ ..."
	@git clone --quiet --filter=blob:none $(PLENARY_URL) $(PLENARY)
	@git -C $(PLENARY) checkout --quiet $(PLENARY_REF)

clean-deps:
	rm -rf $(DEPS)
