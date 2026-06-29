-- SPF style primitives: named, reusable styles built from the palette. The
-- middle layer between raw colors and semantic groups -- groups in
-- spf/groups/* link to these by name (e.g. DiagnosticError = "red").
local colors = require("spf.palette")

return {
  bold = { bold = true },
  underline = { underline = true },
  italic = { italic = true },

  white = { fg = colors.white },
  white_on_black = { fg = colors.white, bg = colors.black },
  white_on_bright_black_bold = { bold = true, fg = colors.white, bg = colors.bright_black },
  bright_white = { fg = colors.bright_white },

  black_on_black = { fg = colors.black, bg = colors.black },
  black_on_red = { fg = colors.black, bg = colors.red },
  black_on_yellow = { fg = colors.black, bg = colors.yellow },
  black_on_green = { fg = colors.black, bg = colors.green },

  bright_black = { fg = colors.bright_black },
  bright_black_bold = { bold = true, fg = colors.bright_black },
  bright_black_strikethrough = { strikethrough = true, fg = colors.bright_black },

  red = { fg = colors.red },
  red_on_black = { fg = colors.red, bg = colors.black },
  red_underline = { fg = colors.red, underline = true },
  bright_red = { fg = colors.bright_red },

  orange = { fg = colors.orange },

  yellow = { fg = colors.yellow },
  yellow_on_black = { fg = colors.yellow, bg = colors.black },
  yellow_italic = { italic = true, fg = colors.yellow },
  yellow_undercurl = { undercurl = true, fg = colors.yellow },

  green = { fg = colors.green },
  green_on_black = { fg = colors.green, bg = colors.black },
  bright_green = { fg = colors.bright_green },
  green_undercurl = { undercurl = true, fg = colors.green },

  cyan = { fg = colors.cyan },
  bright_cyan = { fg = colors.bright_cyan },

  blue = { fg = colors.blue },
  blue_on_black = { fg = colors.blue, bg = colors.black },
  bright_blue = { fg = colors.bright_blue },
  blue_undercurl = { undercurl = true, fg = colors.blue },

  magenta = { fg = colors.magenta },
  magenta_on_black = { fg = colors.magenta, bg = colors.black },
  bright_magenta = { fg = colors.bright_magenta },
  magenta_undercurl = { undercurl = true, fg = colors.magenta },

  rose = { fg = colors.rose },
  bright_gold = { fg = colors.bright_gold },

  -- Folded, WinBar
  primary_accent = {
    fg = colors.primary_accent_foreground,
    bg = colors.primary_accent_background,
  },

  -- WinbarNC
  secondary_accent = {
    fg = colors.secondary_accent_foreground,
    bg = colors.secondary_accent_background,
  },

  --= None
  tertiary_accent = {
    fg = colors.tertiary_accent_foreground,
    bg = colors.tertiary_accent_background,
  },

  nothing_on_visual = { bg = colors.visual_selection },
  nothing_on_cursorline = { bg = colors.cursorline },
  nothing_on_black = { bg = colors.black },
  nothing_on_dark_green = { bg = colors.dark_green },
  nothing_on_dark_yellow = { bg = colors.dark_yellow },
  nothing_on_dark_red = { bg = colors.dark_red },
  nothing_on_dark_blue = { bg = colors.dark_blue },
}
