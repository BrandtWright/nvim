return {
  {
    "folke/trouble.nvim",
    opts = {
      modes = {
        symbols = {
          format = "{kind_icon} {symbol.name}",
        },
      },
    },
    keys = {
      { "<leader>cs", false }, -- Symbols (Trouble)
      { "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
    },
  },
}
