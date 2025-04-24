return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: workspace diagnostics are in snacks
      { "<leader>sD", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
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
