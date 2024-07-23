-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

--------------------------------------------------------------------------------
-- LazyVim Overrides
--------------------------------------------------------------------------------

-- Disable line wrapping in markdown files
vim.api.nvim_clear_autocmds({
  group = "lazyvim_wrap_spell",
  event = "FileType",
  pattern = "markdown",
})
