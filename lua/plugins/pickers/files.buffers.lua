-------------------------------------------------------------------------------
-- Fuzzy find over recent files
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: highlight groups  are handled by snacks
      { "<leader>fb", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>fb",
        Snacks.picker.buffers,
        mode = "n",
        desc = "Recent Files",
      },
    },
  },
}
