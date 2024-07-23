---@class Highlight
---@field name string
---@field fg string | nil
---@field bg string | nil
---@field styles string[] | nil

-- Cross-platform path separator
local path_seperator = require("bw.util.fs").get_path_seperator()

local function get_highlight_files()
  local config_path = vim.fn.stdpath("config")
    .. path_seperator
    .. "lua"
    .. path_seperator
    .. "bw"
    .. path_seperator
    .. "config"
    .. path_seperator
    .. "highlights"
  return vim.fn.readdir(config_path, [[v:val =~ '\.lua$']])
end

---@param styles string[]
---@param style string
---@return boolean
local contains_style = function(styles, style)
  if type(styles) ~= "table" or styles == nil then
    return false
  end
  for _, v in pairs(styles) do
    if v == style then
      return true
    end
  end
  return false
end

local is_bold = function(styles)
  return contains_style(styles, "b")
end

local is_italic = function(styles)
  return contains_style(styles, "i")
end

local is_underline = function(styles)
  return contains_style(styles, "u")
end

local M = {}

local onChanged = function()
  for _, file in ipairs(get_highlight_files()) do
    local requirement = file:gsub("%.lua$", "")
    if requirement ~= "init" then
      M.register(require("bw.config.highlights." .. requirement))
    end
  end
end

M.setup = function()
  -- Load colorscheme overrides when theme changes
  onChanged()
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("ColorSchemeChanged", { clear = true }),
    callback = onChanged,
  })
end

---@param highlights Highlight[]
M.register = function(highlights)
  for _, highlight in pairs(highlights) do
    vim.api.nvim_set_hl(0, highlight.name, {
      fg = highlight.fg,
      bg = highlight.bg,
      bold = is_bold(highlight.styles),
      italic = is_italic(highlight.styles),
      underline = is_underline(highlight.styles),
    })
  end
end

return M
