return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.cmd("hi! link @constructor Special")
    end,
  },
}
