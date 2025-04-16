return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@lsp.type.type.terraform", fg = c.blue, bg = nil, styles = {} },
      })
    end,
  },
}
