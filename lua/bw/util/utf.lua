local M = {}

---comment
---@param str string
---@param index integer
---@return string
M.get_char = function(str, index)
  -- Use vim.str_byteindex to find the byte index of the second character
  local second_char_index = vim.str_byteindex(str, index + 1, true)

  -- Extract the first character using string.sub
  return string.sub(str, 1, second_char_index - 1)
end

return M
