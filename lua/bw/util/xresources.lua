local M = {}

-- Cache for xresources to avoid multiple shell calls
local xres_cache = nil

--- Parses `xrdb -query` output ("key:\tvalue" per line) into a table.
--- Wildcard entries ("*.foreground") are also stored under the stripped key
--- ("foreground"). Pure (no IO), so it is unit-testable.
---@param output string Raw `xrdb -query` output
---@return table<string, string>
M.parse = function(output)
  local result = {}
  for line in output:gmatch("[^\n]+") do
    local key, value = line:match("^([^:]+):%s*(.+)$")
    if key and value then
      -- Store the key as-is (preserve all prefixes)
      result[key] = value

      -- Also store without a leading "*" / "*." wildcard prefix (a wildcard
      -- pattern, not a literal application name). xrdb emits both the dotted
      -- form ("*.color0") and the bare form ("*color0").
      if key:match("^%*") then
        result[key:gsub("^%*%.?", "")] = value
      end
    end
  end
  return result
end

--- Returns `tbl[key]` if it is a valid #rrggbb hex color, otherwise nil. Pure.
---@param tbl table<string, string>
---@param key string
---@return string|nil
M.color = function(tbl, key)
  local value = tbl[key]
  if value and value:match("^#%x%x%x%x%x%x$") then
    return value
  end
end

--- Load all xresources in a single shell call and cache them.
local function load_xresources_batch()
  if xres_cache then
    return xres_cache
  end

  -- Get all xresources in one shell call. Consult v:shell_error so a failure
  -- (e.g. xrdb missing) caches an empty table rather than parsing the error
  -- text into junk keys.
  local output = vim.fn.system("xrdb -query")
  xres_cache = (vim.v.shell_error == 0 and output ~= "") and M.parse(output) or {}
  return xres_cache
end

--- Gets a color from the xresource database
---@param key string
---@return string|nil
M.load = function(key)
  return M.color(load_xresources_batch(), key)
end

return M
