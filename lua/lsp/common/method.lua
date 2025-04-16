return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@method", fg = c.yellow, bg = nil, styles = {} },
        { name = "@method.call", fg = c.yellow, bg = nil, styles = { "i" } },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@lsp.type.method", fg = c.yellow, bg = nil, styles = {} },
      })
    end,
  },
}
