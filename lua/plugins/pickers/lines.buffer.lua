-------------------------------------------------------------------------------
-- Fuzzy find in buffer
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>bl",
        Snacks.picker.lines,
        desc = "Lines",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>bL",
        require("telescope.builtin").current_buffer_fuzzy_find,
        desc = "Telescope Picker",
      },
    },
  },
}
