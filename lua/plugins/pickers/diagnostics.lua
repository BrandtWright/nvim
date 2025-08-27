return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: buffer diagnosics are in snacks
      { "<leader>sd", false },
      { "<leader>sD", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>sd",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Diagnostics (Buffer)",
      },
      {
        "<leader>sD",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics (Workspace)",
      },
    },
  },
}
