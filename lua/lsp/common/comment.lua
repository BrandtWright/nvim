return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.cmd("hi! link @comment Comment")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.cmd("hi! link @lsp.type.comment Comment")
    end,
  },
}
