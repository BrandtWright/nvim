local c = require("bw.config.colors")

return {
  { name = "DiffAdd", fg = c.green, bg = c.terminal },
  { name = "DiffChange", fg = c.yellow, bg = c.terminal },
  { name = "DiffDelete", fg = c.red, bg = c.terminal },
  { name = "DiffText", fg = c.blue, bg = c.terminal },
  { name = "@markup.heading.gitcommit", fg = c.gold, bg = c.terminal },
}
