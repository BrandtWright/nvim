return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.cmd("hi! link @lsp.type.variable Identifier")
      vim.cmd("hi! link @lsp.variable.member Type")
    end,
  },
}
