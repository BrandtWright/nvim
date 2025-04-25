-------------------------------------------------------------------------------
-- Fuzzy find over key maps
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: man pages are handled by snacks
      { "<leader>sM", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sM", Snacks.picker.man, desc = "Man Pages" },
    },
  },
}
