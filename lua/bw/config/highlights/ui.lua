local c = require("bw.config.colors")

return {
  { name = "WinSeparator", fg = c.statusline, bg = c.terminal, styles = {} },
  { name = "EndOfBUffer", fg = c.terminal, bg = c.terminal, styles = {} },
  { name = "Visual", bg = c.visual, styles = {} },
  { name = "CursorLine", bg = c.cursor_line, styles = {} },
  { name = "CursorLineNr", fg = c.comment, bg = c.terminal, styles = {} },
  { name = "LineNr", fg = c.comment, bg = c.terminal, styles = {} },
  { name = "ColorColumn", bg = c.cursor_line, styles = {} },
  { name = "Search", bg = c.visual, styles = {} },
  { name = "CurrentSearch", bg = c.visual, styles = {} },
  { name = "IncSearch", bg = c.visual, styles = {} },
  { name = "NormalFloat", bg = c.terminal, styles = {} },
  { name = "FloatBorder", fg = c.brown, bg = c.terminal, styles = {} },
  { name = "FloatTitle", fg = c.white, bg = c.terminal, styles = {} },
  { name = "SignColumn", bg = c.terminal, styles = {} },
  -- jackMort/ChatGPT.nvim uses this for the gutter in its popups
  { name = "FoldColumn", fg = c.gold, bg = c.terminal, styles = {} },
  { name = "TabLine", fg = c.gray, bg = c.statusline, styles = {} },
  { name = "TabLineSel", fg = c.white, bg = c.statusline, styles = {} },
  { name = "TabLineFill", fg = c.red, bg = c.statusline, styles = {} },
}
