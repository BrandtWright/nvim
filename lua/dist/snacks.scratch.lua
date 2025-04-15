return {
  {
    "folke/snacks.nvim",
    keys = {
      -- Disabled Keys
      { "<leader>S", false }, -- scratch picker is in leader-sp
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
