return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@punctuation.delimiter", fg = c.white, bg = nil, styles = {} },
        { name = "@punctuation.bracket", fg = c.gold, bg = nil, styles = {} },
      })
    end,
  },
}
