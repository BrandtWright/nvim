return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- Silly keys
      { "<leader>ff", false },
      { "<leader>fF", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>fF",
        function()
          Snacks.picker.files({ hidden = true })
        end,
        desc = "All Files (CWD)",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Files (CWD)",
      },
    },
  },
}
