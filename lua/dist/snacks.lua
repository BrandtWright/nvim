vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("DisableSnacksIndentGuides", { clear = true }),
  pattern = "markdown",
  callback = function()
    vim.b.snacks_indent = false
  end,
})

return {}
