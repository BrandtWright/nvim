local M = {}

M.toggle_indent_lines = function()
  -- Snacks
  if package.loaded["snacks"] then
    if Snacks.indent.enabled then
      Snacks.indent.disable()
    else
      Snacks.indent.enable()
    end
  end
  -- mini.indentscope
  if package.loaded["mini.indentscope"] then
    if vim.b.miniindentscope_disable then
      vim.b.miniindentscope_disable = nil
    else
      vim.b.miniindentscope_disable = true
    end
  end
end

return M
