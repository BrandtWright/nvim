return {
  {
    "folke/noice.nvim",
    opts = function()
      vim.cmd("hi! link NoiceCmdlinePopupBorder Special")
      vim.cmd("hi! link NoiceCmdlineIcon Special")
      vim.cmd("hi! link NoiceCmdlinePopupTitle Special")
    end,
  },
}
