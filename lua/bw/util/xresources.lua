local M = {}

--- Gets a color from the xresource database
---@param key string
---@return string|nil
M.load = function(key)
  local color = vim.fn.system({ "xrdb", "-get", key }):gsub("\n", "")
  if not color or color == "" or not color:match("#%x%x%x%x%x%x") then
    return nil
  end
  return color
end

return M
