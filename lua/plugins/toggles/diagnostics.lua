return {
  {
    "folke/snacks.nvim",
    opts = function()
      Snacks.toggle.diagnostics():map("<leader>udd")
    end,
  },
}
