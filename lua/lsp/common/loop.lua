return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@repeat", fg = c.bright_violet, bg = nil, styles = {} },
        { name = "@keyword.repeat", fg = c.bright_violet, bg = nil, styles = {} },
      })
    end,
  },
}
