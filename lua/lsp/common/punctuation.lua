return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.cmd("hi! link @punctuation.special Special")
      vim.cmd("hi! link @punctuation.bracket Special")
      vim.cmd("hi! link @punctuation.delimiter Normal")
    end,
  },
}
