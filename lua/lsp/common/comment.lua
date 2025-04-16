return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@comment", fg = c.gray_34, bg = nil, styles = { "i" } },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@lsp.type.comment", fg = c.gray_34, bg = nil, styles = { "i" } },
      })
    end,
  },
}
