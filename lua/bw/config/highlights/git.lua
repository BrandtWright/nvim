local c = require("bw.config.colors")

return {
  { name = "DiffAdd", fg = c.terminal, bg = c.green },
  { name = "DiffChange", fg = c.terminal, bg = c.yellow },
  { name = "DiffDelete", fg = c.terminal, bg = c.red },
  { name = "DiffText", fg = c.terminal, bg = c.blue },
}
