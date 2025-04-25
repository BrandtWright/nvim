-------------------------------------------------------------------------------
-- Fuzzy find over command history
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: command history is handled by snacks
      { "<leader>:", false },
      -- silly key: command history is handled by snacks
      { "<leader>sc", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>:",
        Snacks.picker.command_history,
        desc = "Command History",
      },
    },
  },
}
