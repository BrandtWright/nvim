local c = require("bw.config.colors")
local highlights = require("bw.config.highlights")
highlights.register({
  { name = "Todo", fg = c.green, bg = c.terminal, styles = {} },
  { name = "TodoSignTODO", fg = c.green, bg = c.terminal, styles = {} },
})

return {
  {
    "folke/todo-comments.nvim",
  },
}
