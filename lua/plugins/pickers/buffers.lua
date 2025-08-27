return {
  ------------------------------------------------------------------------------
  -- Silly Keys
  ------------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fb", false },
      { "<leader>sb", false },
    },
  },
  ------------------------------------------------------------------------------
  -- Pickers
  ------------------------------------------------------------------------------
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>bs",
        function()
          Snacks.picker.buffers()
        end,
        mode = "n",
        desc = "Recent Files",
      },
      {
        "<leader>bl",
        function()
          Snacks.picker.lines({ layout = "default" })
        end,
        desc = "Fuzzy Find in Buffer",
      },
    },
  },
}
