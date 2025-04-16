local c = require("bw.config.colors")
return {
  { name = "Normal", fg = c.white, bg = c.terminal, styles = {} },
  { name = "String", fg = c.orange, bg = nil, styles = {} },
  { name = "Comment", fg = c.gray_34, bg = nil, styles = { "i" } },
  { name = "Special", fg = c.gold, bg = c.terminal, styles = {} },
  { name = "Statement", fg = c.gold, bg = c.terminal, styles = {} },

  ------------------------------------------------------------------------------
  -- Keyword
  ------------------------------------------------------------------------------
  { name = "Keyword", fg = c.blue, bg = nil, styles = {} },
}
