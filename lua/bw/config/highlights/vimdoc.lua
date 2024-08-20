local c = require("bw.config.colors")

return {
  { name = "@label.vimdoc", fg = c.gold },
  { name = "@markup.heading.1.vimdoc", fg = c.beige, bg = c.terminal, styles = {} },
  { name = "@markup.link.vimdoc", fg = c.yellow, bg = c.terminal, styles = {} },
  { name = "@variable.parameter.vimdoc", fg = c.green, bg = c.terminal, styles = {} },
  { name = "@keyword.exception.vim", fg = c.red, bg = c.terminal, styles = {} },
}
