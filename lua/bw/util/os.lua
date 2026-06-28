local M = {}

M.path_separator = function()
  return package.config:sub(1, 1)
end

return M
