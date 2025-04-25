-------------------------------------------------------------------------------
-- Fuzzy find over command history
-- key map: `<leader>:`
-------------------------------------------------------------------------------
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
        Snacks.picker.command_history,
        desc = "Command History",
      },
    },
  },
}
