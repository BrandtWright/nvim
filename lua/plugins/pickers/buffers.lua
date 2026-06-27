return {
  ------------------------------------------------------------------------------
  -- Pickers
  ------------------------------------------------------------------------------
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>bs",
        function()
          Snacks.picker.buffers()
        end,
        mode = "n",
        desc = "Fuzy Find Buffers",
      },
      {
        "<leader>bl",
        function()
          Snacks.picker.lines({ layout = "default" })
        end,
        desc = "Fuzzy Find in Buffer",
      },
    },
  },
}
