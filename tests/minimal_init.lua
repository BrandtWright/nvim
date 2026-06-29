-- Headless test bootstrap.
--
-- Puts the config root and a test-only copy of plenary on the runtimepath so
-- specs can `require()` individual modules / plugin-spec files WITHOUT booting
-- lazy.nvim or loading any real plugins. Run via `make test`.

local this = debug.getinfo(1, "S").source:sub(2)
local tests_dir = vim.fn.fnamemodify(this, ":p:h")
local root = vim.fn.fnamemodify(tests_dir, ":h")

-- Note: specs derive the config root from their own path rather than
-- vim.fn.stdpath("config") — in a sandbox/CI HOME may differ, making stdpath
-- point at a non-existent dir.
vim.opt.rtp:prepend(root)
vim.opt.rtp:prepend(root .. "/.tests-deps/plenary.nvim")
-- The config's after/ dir is a separate rtp entry (sourced last, so its
-- after/ftplugin/* overrides built-in ftplugins). Needed to test ftplugins.
vim.opt.rtp:append(root .. "/after")

vim.g.mapleader = " "
-- Match the running config (lua/config/options.lua): localleader is "\\", not
-- Space. Keeping it distinct from mapleader here mirrors reality, so specs that
-- touch <localleader> maps behave as they do in the real config.
vim.g.maplocalleader = "\\"

vim.cmd("runtime plugin/plenary.vim")
