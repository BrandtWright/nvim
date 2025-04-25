-------------------------------------------------------------------------------
-- Fuzzy find over autocommands
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: autocommands are handled by snacks
      { "<leader>sa", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sa", Snacks.picker.autocmds, desc = "Auto Commands" },
    },
  },
}
