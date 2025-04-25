-------------------------------------------------------------------------------
--"Fuzzy find over command history
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: registers are handled by snacks
      { '<leader>s"', false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>s'", Snacks.picker.registers, desc = "Registers" },
    },
  },
}
