--------------------------------------------------------------------------------
-- Color Pallet
--------------------------------------------------------------------------------
--
-- Primary Colors:
--   red, green and blue
--
-- Secondary Colors:
--   cyan, magenta and yellow
--
-- Tertiary Colors:
--   orange, chartreuse green, spring green, azure, violet and rose
--
-- Extended Colors:
--   brown, bold
--
-- Shades:
--
-- TODO: Move load_color() to an xresource module
-- TODO: colors.terminal -> too many refs. Deduplicate with highlight links
--
--------------------------------------------------------------------------------

--- Gets a color from the xresource database
---@param key string
---@return string|nil
local load_color = function(key)
  local color = vim.fn.system({ "xrdb", "-get", key }):gsub("\n", "")
  if not color or color == "" or not color:match("#%x%x%x%x%x%x") then
    return nil
  end
  return color
end

local colors = {

  -- Normal
  black = load_color("color0") or "#575757",
  red = load_color("color1") or "#bd7671",
  green = load_color("color2") or "#769482",
  yellow = load_color("color3") or "#c2c27c",
  blue = load_color("color4") or "#5692db",
  magenta = load_color("color5") or "#8f7099",
  cyan = load_color("color6") or "#7b919e",
  white = load_color("color7") or "ebdbb2",

  -- Bright
  bright_black = load_color("color8") or "#737373",
  bright_red = load_color("color9") or "#ffa099",
  bright_green = load_color("color10") or "#b9d9b8",
  bright_yellow = load_color("color11") or "#fcfca4",
  bright_blue = load_color("color12") or "#77b3fc",
  bright_magenta = load_color("color13") or "#c99fd6",
  bright_cyan = load_color("color14") or "#a7cacc",
  bright_white = load_color("color15") or "#fff2d1",

  -- Tertiary Colors
  orange = load_color("screen_glasses.ui.orange") or "#ce9178",
  dark_violet = load_color("screen_glasses.ui.dark_violet") or "#8a7989", -- @lsp.type.delegateName.cs
  violet = load_color("screen_glasses.ui.violet") or "#8a7b9e",
  bright_violet = load_color("screen_glasses.ui.bright_violet") or "#eebaff",

  -- Extended Colors
  brown = load_color("screen_glasses.ui.brown") or "#473d37", -- Mostly UI elements
  gold = load_color("screen_glasses.ui.gold") or "#a38e5d", -- Lots of LSP stuff

  -- Terminal (Normal Background)
  terminal = load_color("background") or "#171717",

  -- CursorLine, ColorColumn, TelescopeSelection
  gray_10 = load_color("screen_glasses.ui.gray_10") or "#1a1a1a",
  -- Comment, @Comment, @lsp.type.comment
  gray_34 = load_color("screen_glasses.ui.gray_34") or "#575757",
  -- Visual
  gray_50 = load_color("screen_glasses.ui.gray_50") or "#333333",

  -- Search, CurrentSearch, IncSearch
  resolution_blue = load_color("screen_glasses.ui.resolution_blue") or "#202080",

  -- Primary Window Chrome
  --    Tabline, TabLineSel, TabLineFill, WinSeparator, Lualine, TelescopeSelection
  raisin_black = load_color("screen_glasses.ui.raisin_black") or "#2C2826",

  cursorline = load_color("screen_glasses.ui.cursor_line_background") or "1a1816",
}

return colors
