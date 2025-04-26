-------------------------------------------------------------------------------
-- Fuzzy find man pages
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>srt", require("telescope.builtin").resume, desc = "Telescope Picker" },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>srs", Snacks.picker.resume, desc = "Snacks Picker" },
    },
  },
}
