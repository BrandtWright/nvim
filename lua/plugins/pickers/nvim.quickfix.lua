-------------------------------------------------------------------------------
-- Fuzzy find quickfix list items
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: quickfixes are handled by snacks
      { "<leader>sq", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sq", Snacks.picker.qflist, desc = "Quickfix List" },
    },
  },
}
