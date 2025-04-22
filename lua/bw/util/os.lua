local M = {}

M.path_seperator = function()
  return package.config:sub(1, 1)
end

return M
