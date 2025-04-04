return {

  {
    "LazyVim/LazyVim",
    keys = {

      ------------------------------------------------------------------------------
      -- Disabled Keys
      ------------------------------------------------------------------------------
      {
        "<leader>ls",
        function()
          vim.cmd("Lazy")
        end,
        desc = "Lazy.nvim Status",
      },
      {
        "<leader>ll",
        function()
          LazyVim.news.changelog()
        end,
        desc = "Lazy Log",
      },
      {
        "<leader>lc",
        function()
          require("snacks").picker.lazy()
        end,
        desc = "Lazy Config",
      },
    },
  },
}
