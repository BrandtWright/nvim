return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.cmd("hi! link @keyword.operator red")
      vim.cmd("hi! link @keyword Keyword")
      vim.cmd("hi! link @keyword.function Keyword")
      vim.cmd("hi! link @keyword.repeat Repeat")
      vim.cmd("hi! link @keyword.conditional Conditional")
    end,
  },
}
