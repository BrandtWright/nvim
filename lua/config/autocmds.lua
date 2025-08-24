-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

--------------------------------------------------------------------------------
-- LazyVim Overrides
--------------------------------------------------------------------------------

-- Disable lazyvim autocmd for line wrapping and spell in markdown files
-- because it is annoying.
vim.api.nvim_clear_autocmds({
  group = "lazyvim_wrap_spell",
  event = "FileType",
  pattern = "markdown",
})
