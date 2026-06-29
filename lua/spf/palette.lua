-- SPF palette: raw colors, sourced from xresources (screen_glasses.*) with
-- baked-in fallbacks. The single source of hex values for the theme.
local load = require("bw.util.xresources").load
local ui_prefix = "screen_glasses.ui."
local extended_color_prefix = "screen_glasses.extended_colors."

return {
  black = load("color0") or "#1a1614", --  hsl(20 13% 9%)
  white = load("color7") or "#ebdbb2", --  hsl(43 59% 81%)
  red = load("color1") or "#c88484", --  hsl(0 38% 65%)
  yellow = load("color3") or "#c0c587", --  hsl(65 35% 65%)
  green = load("color2") or "#7b9d80", --  hsl(129 15% 55%)
  cyan = load("color6") or "#7096a9", --  hsl(200 25% 55%)
  blue = load("color4") or "#899fd2", --  hsl(222 45% 68%)
  magenta = load("color5") or "#c494db", --  hsl(280 50% 72%)
  orange = load(extended_color_prefix .. "orange") or "#dba270", --  hsl(28 60% 65%)
  rose = load(extended_color_prefix .. "rose") or "#e892b1", --  hsl(338 65% 74%)

  bright_black = load("color8") or "#756157", --  hsl(20 15% 40%)
  bright_white = load("color15") or "#f6eedb", --  hsl(43 59% 91%)
  bright_red = load("color9") or "#dea1a1", --  hsl(0 48% 75%)
  bright_yellow = load("color11") or "#d2d6a9", --  hsl(65 35% 75%)
  bright_green = load("color10") or "#a7beaa", --  hsl(128 15% 70%)
  bright_cyan = load("color14") or "#9fb9c6", --  hsl(200 25% 70%)
  bright_blue = load("color12") or "#a2b8eb", --  hsl(222 65% 78%)
  bright_magenta = load("color13") or "#ddaff4", --  hsl(280 75% 82%)
  bright_orange = load(extended_color_prefix .. "bright_orange") or "#e5bd99", --  hsl(28 60% 75%)
  bright_rose = load(extended_color_prefix .. "bright_rose") or "#f5b8ce", --  hsl(338 75% 84%)
  bright_gold = load(extended_color_prefix .. "bright_gold") or "#a38e5c", --  hsl(42 28% 50%)

  dark_green = load(ui_prefix .. "diff_add") or "#1b271e", --  hsl(135 18% 13%)
  dark_yellow = load(ui_prefix .. "diff_change") or "#241b00", --  hsl(45 100% 7%)
  dark_red = load(ui_prefix .. "diff_delete") or "#2a1313", --  hsl(0 38% 12%)
  dark_blue = load(ui_prefix .. "diff_text") or "#0e1423", --  hsl(223 43% 10%)

  primary_accent_foreground = load(ui_prefix .. "primary_accent_foreground") or "#a8948a", --  hsl(20 15% 60%)
  primary_accent_background = load(ui_prefix .. "primary_accent_background") or "#221c19", --  hsl(20 15% 12%)
  secondary_accent_foreground = load(ui_prefix .. "secondary_accent_foreground") or "#a8948a", --  hsl(20 15% 60%)
  secondary_accent_background = load(ui_prefix .. "secondary_accent_background") or "#382e29", --  hsl(20 15% 19%)
  tertiary_accent_foreground = load(ui_prefix .. "tertiary_accent_foreground") or "#221c19", --  hsl(20 15% 12%)
  tertiary_accent_background = load(ui_prefix .. "tertiary_accent_background") or "#a8948a", --  hsl(20 15% 60%)
  cursorline = load(ui_prefix .. "cursor_line") or "#221c19", --  hsl(20 15% 12%)
  visual_selection = load(ui_prefix .. "visual_selection") or "#333333", --  hsl(0 0% 20%)
}
