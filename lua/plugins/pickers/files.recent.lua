-------------------------------------------------------------------------------
-- Fuzzy find over recent files
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>fo",
        Snacks.picker.recent,
        mode = "n",
        desc = "Recent Files",
      },
    },
  },
}
