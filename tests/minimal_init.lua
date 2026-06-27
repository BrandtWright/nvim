-- Headless test bootstrap.
--
-- Puts the config root and a test-only copy of plenary on the runtimepath so
-- specs can `require()` individual modules / plugin-spec files WITHOUT booting
-- lazy.nvim or loading any real plugins. Run via tests/run.sh.

local this = debug.getinfo(1, "S").source:sub(2)
local tests_dir = vim.fn.fnamemodify(this, ":p:h")
local root = vim.fn.fnamemodify(tests_dir, ":h")

-- Note: specs derive the config root from their own path rather than
-- vim.fn.stdpath("config") — in a sandbox/CI HOME may differ, making stdpath
-- point at a non-existent dir.
vim.opt.rtp:prepend(root)
vim.opt.rtp:prepend(root .. "/.tests-deps/plenary.nvim")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd("runtime plugin/plenary.vim")
