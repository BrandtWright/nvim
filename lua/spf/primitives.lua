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

  -- UI chrome system (see colors.md "UI"). Built from orthogonal axes:
  --   surface    one dark warm bg for all chrome (depth read from the border)
  --   focus      foreground strength (chrome_active vs chrome_inactive)
  --   emphasis   neutral-gray background for current/selected (selection)
  --   recede     one dim foreground (bright_black) for meta/structural text
  -- current_line is its own faint warm lift, deliberately kept out of the gray
  -- emphasis family so it blends with Normal.

  -- surface x focus: window chrome (statusline, winbar, tabline)
  chrome_active = { fg = colors.chrome_fg, bg = colors.surface },
  chrome_inactive = { fg = colors.bright_black, bg = colors.surface },
  -- emphasis: current/selected items -- neutral gray reads over any surface
  selection = { bg = colors.visual_selection },
  -- emphasis (strong): inverted block for the cursor
  cursor_block = { fg = colors.black, bg = colors.chrome_fg },
  -- structure: the current content line -- faint warm lift, blends with Normal
  current_line = { bg = colors.cursorline },
  -- recede: dim editor furniture & messages (line numbers, folds, non-text). A UI
  -- concept, not a color -- it borrows `bright_black` for now (see `ghost`).
  recede = { fg = colors.bright_black },

  -- Composite UI concepts (see colors.md "Panels & controls"). Application-
  -- agnostic: a panel hosts controls. spf is one realization; the same concepts
  -- drive tmux/xmobar/dmenu from the shared xresources tones.
  --   panel    framed container/bar -- its frame band + title fg
  --   textbox  editable text input -- content-bright fg on its own field bg
  --   list     selectable item list -- normal items; selected item -> selection
  --   view     embedded content buffer -> the content plane (Normal); no primitive
  panel = { fg = colors.white, bg = colors.surface_border },
  textbox = { fg = colors.white, bg = colors.textbox_bg },
  list = { fg = colors.white, bg = colors.surface },
  -- a panel edge drawn as a line (FloatBorder) rather than a solid band
  border = { fg = colors.surface_border },
  -- Text on a control has two neutral prominence levels:
  --   label  the legible default fg (titles, the value, item names) -- just the
  --          surface's own fg, no role of its own
  --   ghost  muted secondary text (counts, placeholders, metadata, descriptions)
  -- `ghost` is a UI *concept*, not a color: it borrows `bright_black` today (free,
  -- at hand) but is named so it stays decoupled from syntax -- `Comment` is also
  -- bright_black, yet that's coincidence, not coupling. UI groups link to `ghost`,
  -- never the raw tone, so the two domains can diverge later.
  ghost = { fg = colors.bright_black },
  nothing_on_dark_green = { bg = colors.dark_green },
  nothing_on_dark_yellow = { bg = colors.dark_yellow },
  nothing_on_dark_red = { bg = colors.dark_red },
  nothing_on_dark_blue = { bg = colors.dark_blue },
}
