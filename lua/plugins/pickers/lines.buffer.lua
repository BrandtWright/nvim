-------------------------------------------------------------------------------
-- Fuzzy find in buffer
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>bf",
        function()
          Snacks.picker.lines({ layout = "default" })
        end,
        desc = "Fuzzy Find in Buffer",
      },
    },
  },
}
