return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@operator", fg = c.white, bg = nil, styles = {} },
        { name = "@keyword.operator", fg = c.bright_red, bg = nil, styles = {} },
      })
    end,
  },
}
