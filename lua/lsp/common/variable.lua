return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@lsp.type.variable", fg = c.white, bg = nil, styles = {} },
        { name = "@lsp.variable.member", fg = c.green, bg = nil, styles = {} },
      })
    end,
  },
}
