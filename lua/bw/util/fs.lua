local M = {}

--- Returns true if the file backing `buf` is larger than `max_size` bytes.
--- An unnamed buffer (or one whose file cannot be stat'd) is treated as not
--- exceeding the limit.
---@param buf integer Buffer handle
---@param max_size integer Size threshold in bytes
---@return boolean
M.buff_exceeds_size = function(buf, max_size)
  local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_size then
    return true
  end
  return false
end

return M
