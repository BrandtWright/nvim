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

-- Show the column number (useful when in zen mode).
vim.api.nvim_create_user_command("Column", function()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local msg = string.format("Col: %d", col + 1)
  require("bw.util.notification").info(msg, "Column Toaster", "💡")
end, { desc = "Show current cursor column" })
