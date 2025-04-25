-------------------------------------------------------------------------------
-- Fuzzy find over command history
-- key map: `<leader>:`
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: autocommands are handled by snacks
      { "<leader>sa", false }, -- Auto commands are in snacks
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sa", Snacks.picker.autocmds, desc = "Auto Commands" },
    },
  },
}
