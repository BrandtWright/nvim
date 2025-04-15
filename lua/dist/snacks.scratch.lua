return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>sp",
        function()
          Snacks.scratch.select()
        end,
        desc = "Scratch Pad Picker (Snacks)",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch.open()
        end,
        desc = "Open Scratch Pad (Snacks)",
      },
    },
  },
}
