-------------------------------------------------------------------------------
-- Fuzzy find in buffer
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: config file picker is handled by snacks
      { "<leader>sb", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>sb",
        function()
          Snacks.picker.lines({ layout = "default" })
        end,
        desc = "Fuzzy Find in Buffer",
      },
    },
  },
}
