-------------------------------------------------------------------------------
-- Fuzzy find the jump list
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: jumps are handled by snacks
      { "<leader>sj", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sj", Snacks.picker.jumps, desc = "Jump List" },
    },
  },
}
