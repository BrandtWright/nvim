return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@keyword", fg = c.blue, bg = nil, styles = {} },
        { name = "@keyword.function", fg = c.blue, bg = nil, styles = {} },
        { name = "@keyword.return", fg = c.blue, bg = nil, styles = {} },
      })
    end,
  },
}
