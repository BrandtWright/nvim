return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.cmd("hi! link @keyword.operator Critical")
      vim.cmd("hi! link @keyword Keyword")
      vim.cmd("hi! link @keyword.function Keyword")
      vim.cmd("hi! link @keyword.return Keyword")
      vim.cmd("hi! link @keyword.repeat Repeat")
      vim.cmd("hi! link @keyword.conditional Statement")
    end,
  },
}
