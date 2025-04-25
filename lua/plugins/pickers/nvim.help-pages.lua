-------------------------------------------------------------------------------
-- Fuzzy find over key maps
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: pages are handled by snacks
      { "<leader>sh", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sh", Snacks.picker.help, desc = "Help Pages" },
    },
  },
}
