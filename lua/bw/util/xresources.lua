local M = {}

-- Cache for xresources to avoid multiple shell calls
local xres_cache = nil

--- Load all xresources in a single call and cache them
local function load_xresources_batch()
  if xres_cache then
    return xres_cache
  end

  xres_cache = {}

  -- Get all xresources in one shell call
  local ok, output = pcall(vim.fn.system, "xrdb -query")
  if not ok or not output or output == "" then
    return xres_cache
  end

  -- Parse each line: "key:\tvalue"
  for line in output:gmatch("[^\n]+") do
    local key, value = line:match("^([^:]+):%s*(.+)$")
    if key and value then
      -- Store the key as-is (preserve all prefixes)
      xres_cache[key] = value

      -- Also store without "*." prefix for backward compatibility with wildcard entries
      -- Only strip "*." if it's at the start (wildcard pattern, not literal application name)
      if key:match("^%*%.") then
        local stripped_key = key:gsub("^%*%.", "")
        xres_cache[stripped_key] = value
      end
    end
  end

  return xres_cache
end

--- Gets a color from the xresource database
---@param key string
---@return string|nil
M.load = function(key)
  local cache = load_xresources_batch()
  local value = cache[key]

  -- Only return hex colors (maintain compatibility with original behavior)
  if value and value:match("^#%x%x%x%x%x%x$") then
    return value
  end

  return nil
end

return M
