-------------------------------------------------------------------------------
-- Fuzzy find over command history
-- key map: `<leader>:`
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: commands are handled by snacks
      { "<leader>sC", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>sc",
        Snacks.picker.commands,
        desc = "Command",
      },
    },
  },
}
