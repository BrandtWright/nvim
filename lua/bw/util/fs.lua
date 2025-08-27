local M = {}

local is_string = function(str)
  return type(str) == "string"
end

M.is_valid_path = function(path)
  if not is_string(path) then
    return false
  end
  local stat = vim.uv.fs_stat(vim.fn.expand(path))
  return stat ~= nil
end

--- Returns true if `path` is a directory
---@param path string
---@return boolean
M.is_directory = function(path)
  if not is_string(path) then
    return false
  end
  local file_path = vim.fn.expand(path)
  local stat = vim.uv.fs_stat(vim.fn.expand(file_path))
  return stat ~= nil and stat.type == "directory"
end

M.is_file = function(path)
  if not is_string(path) then
    return false
  end
  local file_path = vim.fn.expand(path)
  local stat = vim.uv.fs_stat(vim.fn.expand(file_path))
  return stat ~= nil and stat.type == "file"
end

M.base_path = function(path)
  if not is_string(path) then
    return ""
  end
  if not M.is_file(path) then
    return ""
  end
  local file_path = vim.fn.expand(path)
  local base_path
  if vim.uv.os_uname().version:match("Windows") then
    base_path = file_path:match("(.*\\)")
  else
    base_path = file_path:match("(.*/)")
  end
  return base_path
end

M.buff_exceeds_size = function(buf, max_size)
  local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_size then
    return true
  end
end

return M
