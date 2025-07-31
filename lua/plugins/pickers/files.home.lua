return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>fh",
        function()
          Snacks.picker.files({ dirs = { vim.fn.expand("~") } })
        end,
        desc = "Files (Home Directory)",
      },
      {
        "<leader>fH",
        function()
          Snacks.picker.files({ dirs = { vim.fn.expand("~") }, hidden = true })
        end,
        desc = "All Files (Home Directory)",
      },
    },
  },
}
