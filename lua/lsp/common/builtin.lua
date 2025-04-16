return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@function.builtin", fg = c.gold, bg = nil, styles = {} },
        { name = "@constant.builtin", fg = c.gold, bg = nil, styles = { "i" } },
      })
    end,
  },
}
