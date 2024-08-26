--------------------------------------------------------------------------------
-- Color Pallet
--------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------

local colors = {

  -- Normal
  white = "#ebdbb2",
  black = "#575757",
  red = "#bd7671",
  green = "#769482",
  yellow = "#c2c27c",
  blue = "#5692db",
  magenta = "#8f7099",
  cyan = "#7b919e",

  -- Bright
  bright_white = "#fff2d1",
  bright_black = "#737373",
  bright_red = "#ffa099",
  bright_green = "#b9d9b8",
  bright_yellow = "#fcfca4",
  bright_blue = "#77b3fc",
  bright_magenta = "#c99fd6",
  bright_cyan = "#a7cacc",

  -- Dark
  dark_red = "#663f3f", -- Markdown only
  dark_orange = "#735244", -- Markdown only

  -- Secondary Colors
  orange = "#ce9178",
  dark_violet = "#8a7989", -- @lsp.type.delegateName.cs
  violet = "#8a7b9e",
  bright_violet = "#eebaff",

  -- Tertiary and Extended Colors
  brown = "#473d37",
  gold = "#a38e5d",

  -- TODO: Too many references... Dedupplicate with highlight links
  terminal = "#171717",

  -- CursorLine, ColorColumn, TelescopeSelection
  gray_10 = "#1a1a1a",
  -- Comment, @Comment, @lsp.type.comment
  gray_34 = "#575757",
  -- Visual
  gray_50 = "#333333",

  -- Search, CurrentSearch, IncSearch
  resolution_blue = "#202080",

  -- Primary Window Chrome
  --    Tabline, TabLineSel, TabLineFill, WinSeparator, Lualine, TelescopeSelection
  raisin_black = "#2C2826",
}

return colors
