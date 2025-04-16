return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@character.printf", fg = c.bright_green, bg = nil, styles = {} },
      })
    end,
  },
}
