return {
  {
    "folke/snacks.nvim",
    opts = function()
      Snacks.toggle.zoom():map("<leader>wm")
    end,
  },
}
