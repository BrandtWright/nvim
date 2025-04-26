-------------------------------------------------------------------------------
-- Fuzzy find location list items
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: location list is handled by snacks
      { "<leader>sl", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sl", Snacks.picker.loclist, desc = "Location List" },
    },
  },
}
