return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@boolean", fg = c.cyan, bg = nil, styles = { "i" } },
      })
    end,
  },
}
