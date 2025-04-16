return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@number", fg = c.white, bg = nil, styles = { "i" } },
      })
    end,
  },
}
