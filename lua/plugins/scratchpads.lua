return {
  {
    "folke/snacks.nvim",
    keys = {
      -- silly key: scratch pad picker -> leader-sp
      { "<leader>S", false },
      -- Scratch pad picker
      {
        "<leader>sp",
        function()
          Snacks.scratch.select()
        end,
        desc = "Scratch Pad Picker (Snacks)",
      },
      -- Contextual Scratch pad
      {
        "<leader>.",
        function()
          Snacks.scratch.open()
        end,
        desc = "Contextual Scratch Pad (Snacks)",
      },
    },
  },
}
