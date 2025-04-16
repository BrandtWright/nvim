return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@label.json", fg = c.green, bg = c.terminal, styles = {} },
      })
    end,
  },
}
