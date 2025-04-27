return {
  {
    "folke/snacks.nvim",
    keys = {
      -- silly key: scratch pad picker -> leader-sp
      { "<leader>S", false },
      -- Scratch pad picker
      { "<leader>sp", Snacks.scratch.select, desc = "Scratch Pad Picker (Snacks)" },
      -- Contextual Scratch pad
      { "<leader>.", Snacks.scratch.open, desc = "Contextual Scratch Pad (Snacks)" },
    },
  },
}
