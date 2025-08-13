local M = {}
--- Utility to get color values
---@param group string
---@param attr string
M.get_attribute = function(group, attr)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  if hl and hl[attr] then
    return string.format("#%06x", hl[attr])
  end
end

return M
