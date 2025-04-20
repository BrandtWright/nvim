return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.cmd("hi! link @lsp.type.parameter Italicized")
    end,
  },
}
