return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.cmd("hi! link @function Function")
      vim.cmd("hi! link @function.call FunctionCall")
      vim.cmd("hi! link @function.builtin Special")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.cmd("hi! link @lsp.type.function Function")
      vim.cmd("hi! link @lsp.typemod.function Function")
    end,
  },
}
