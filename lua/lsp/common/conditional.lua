return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@conditional", fg = c.violet, bg = nil, styles = {} },
        { name = "@keyword.conditional", fg = c.violet, bg = nil, styles = {} },
      })
    end,
  },
}
