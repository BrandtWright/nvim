local c = require("bw.config.colors")

return {

  -- Search
  { name = "Search", bg = c.resolution_blue, styles = {} },
  { name = "CurrentSearch", bg = c.resolution_blue, styles = {} },
  { name = "IncSearch", bg = c.resolution_blue, styles = {} },

  -- Selection
  { name = "Visual", bg = c.gray_50, styles = {} },

  -- Floats
  { name = "NormalFloat", bg = c.terminal, styles = {} },
  { name = "FloatBorder", fg = c.brown, bg = c.terminal, styles = {} },
  { name = "FloatTitle", fg = c.white, bg = c.terminal, styles = {} },

  -- Tabs
  { name = "TabLine", fg = c.bright_black, bg = c.raisin_black, styles = {} },
  { name = "TabLineSel", fg = c.white, bg = c.raisin_black, styles = {} },
  { name = "TabLineFill", fg = c.red, bg = c.raisin_black, styles = {} },

  -- Main Window
  { name = "WinSeparator", fg = c.raisin_black, bg = c.terminal, styles = {} },
  { name = "EndOfBUffer", fg = c.terminal, bg = c.terminal, styles = {} },
  { name = "SignColumn", bg = c.terminal, styles = {} },
  { name = "CursorLineNr", fg = c.brown, bg = c.terminal, styles = {} },
  { name = "LineNr", fg = c.brown, bg = c.terminal, styles = {} },
  -- jackMort/ChatGPT.nvim uses `FoldColumn` for the gutter in its popups
  { name = "FoldColumn", fg = c.gold, bg = c.terminal, styles = {} },
  { name = "CursorLine", bg = c.gray_10, styles = {} },
  { name = "ColorColumn", bg = c.gray_10, styles = {} },
}
