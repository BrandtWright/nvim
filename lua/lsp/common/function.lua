return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@function", fg = c.yellow, bg = nil, styles = {} },
        { name = "@function.call", fg = c.yellow, bg = nil, styles = { "i" } },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@lsp.type.function", fg = c.yellow, bg = nil, styles = {} },
        { name = "@lsp.typemod.function.", fg = c.yellow, bg = nil, styles = {} },
      })
    end,
  },
}
