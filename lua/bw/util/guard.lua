local M = {}

M.is_nil = function(value)
  return value == nil
end

M.not_nil = function(value)
  return value ~= nil
end

M.is_string = function(str)
  return type(str) == "string"
end

M.str = {}

M.str.is_nil = function(str)
  return M.is_nil(str)
end

M.str.is_empty = function(str)
  return str == ""
end

M.str.is_nil_or_empty = function(str)
  return M.str.is_nil(str) or M.str.is_empty(str)
end

return M
