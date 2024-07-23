local M = {}

M.is_valid_path = function(path)
  local stat = vim.loop.fs_stat(vim.fn.expand(path))
  return stat ~= nil
end

M.is_directory = function(path)
  local stat = vim.loop.fs_stat(vim.fn.expand(path))
  return stat ~= nil and stat.type == "directory"
end

M.buff_exceeds_size = function(buf, max_size)
  local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_size then
    return true
  end
end

-- Cross platform path seperator
M.get_path_seperator = function()
  return package.config:sub(1, 1)
end

return M
