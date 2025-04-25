-------------------------------------------------------------------------------
-- Fuzzy find  marks
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: marks are handled by snacks
      { "<leader>sm", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sm", Snacks.picker.marks, desc = "Marks" },
    },
  },
}
