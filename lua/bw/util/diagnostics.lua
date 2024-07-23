M = {}

M.opts = {
  float = {
    show_header = true,
    border = "single",
  },
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
}

M.diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

M.toggle_virtual_text = function()
  if not vim.diagnostic.config().virtual_text then
    vim.diagnostic.config({ virtual_text = M.opts.virtual_text })
    vim.notify("Enabled Virtual Text", vim.log.levels.INFO, { title = "Diagnostics", icon = "🛠" })
  else
    vim.diagnostic.config({ virtual_text = false })
    vim.notify("Disabled Virtual Text", vim.log.levels.WARN, { title = "Diagnostics", icon = "🛠" })
  end
end

M.toggle_diagnostics = function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
    vim.notify("Disabled Diagnostics", vim.log.levels.WARN, { title = "Diagnostics", icon = "🛠" })
  else
    vim.diagnostic.enable()
    vim.notify("Enabled Diagnostics", vim.log.levels.INFO, { title = "Diagnostics", icon = "🛠" })
  end
end

return M
