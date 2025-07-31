return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: disable default mapping for live_grep
      { "<leader>/", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>rr",
        function()
          Snacks.picker.grep()
        end,
        desc = "From CWD",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "From CWD",
      },
    },
  },
}
