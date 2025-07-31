-------------------------------------------------------------------------------
-- Fuzzy find over recent files
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
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
