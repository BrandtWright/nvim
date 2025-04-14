return {
  {
    "folke/noice.nvim",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "NoiceCmdlinePopupBorder", fg = c.gold, bg = c.terminal, styles = {} },
        { name = "NoiceCmdlineIcon", fg = c.gold, bg = c.terminal, styles = {} },
        { name = "NoiceCmdlinePopupTitle", fg = c.gold, bg = c.terminal, styles = {} },
      })
    end,
  },
}
