local M = {}

function M.get_zettle_path(entry)
  local _, j = string.find(entry, ":")
  local path = string.sub(entry, 1, j - 1)
  return path
end

function M.get_zettle_title(entry)
  local _, j = string.find(entry, ":")
  local remaining = string.sub(entry, j + 1)
  _, j = string.find(remaining, ":")
  local title = string.sub(remaining, 1, j - 1)
  return title
end

return M
