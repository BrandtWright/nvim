-------------------------------------------------------------------------------
-- Fuzzy find over key maps
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: key maps are handled by snacks
      { "<leader>sk", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sk", Snacks.picker.keymaps, desc = "Key Maps" },
    },
  },
}
