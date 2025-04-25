-------------------------------------------------------------------------------
-- Fuzzy find over highlight groups
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: highlight groups  are handled by snacks
      { "<leader>sH", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sH", Snacks.picker.highlights, desc = "Highlights" },
    },
  },
}
