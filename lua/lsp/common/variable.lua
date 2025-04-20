return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.cmd("hi! link @variable Identifier")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.cmd("hi! link @lsp.variable.member Type")
    end,
  },
}
