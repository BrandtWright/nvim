return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@property", fg = c.green, bg = nil, styles = {} },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@lsp.type.property", fg = c.green, bg = nil, styles = {} },
      })
    end,
  },
}
