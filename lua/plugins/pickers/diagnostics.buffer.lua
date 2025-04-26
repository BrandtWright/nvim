return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: buffer diagnosics are in snacks
      { "<leader>sd", false },
    },
  },

  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sd", Snacks.picker.diagnostics_buffer, desc = "Diagnostics (Buffer)" },
    },
  },
}
