local c = require("bw.config.colors")
local highlights = require("bw.config.highlights")
highlights.register({
  { name = "MiniIndentscopeSymbol", fg = c.gold, bg = nil, styles = {} }, --   Animations between squirely braces
})

return {
  {
    "echasnovski/mini.indentscope",
  },
}
