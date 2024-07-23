local c = require("bw.config.colors")
local highlights = require("bw.config.highlights")
highlights.register({
  { name = "NoiceCmdlinePopupBorder", fg = c.green, bg = c.terminal, styles = {} },
  { name = "NoiceCmdlineIcon", fg = c.green, bg = c.terminal, styles = {} },
  { name = "NoiceCmdlinePopupTitle", fg = c.green, bg = c.terminal, styles = {} },
  { name = "NoiceSplit", fg = nil, bg = c.terminal, styles = {} },
})

return {
  {
    "folke/noice.nvim",
  },
}
