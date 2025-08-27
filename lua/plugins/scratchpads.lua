return {
  {
    "folke/snacks.nvim",
    -- stylua: ignore
    keys = {
      -- silly key: scratch pad picker -> leader-sp
      { "<leader>S", false },
      { "<leader>sp", function() Snacks.scratch.select() end, desc = "Scratch Pad Picker (Snacks)", },
      { "<leader>.", function() Snacks.scratch.open() end, desc = "Contextual Scratch Pad (Snacks)", },
    },
  },
}
