return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.cmd("hi! link @property Property")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.cmd("hi! link @lsp.type.property Property")
    end,
  },
}
