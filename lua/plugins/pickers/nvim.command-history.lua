return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: command history is handled by snacks
      { "<leader>:", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
    },
  },
}
