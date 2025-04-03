return {

  {
    "LazyVim/LazyVim",
    keys = {
      { "<leader>l", false },
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
        desc = "Lazy.nvim Status",
      },
      {
        "<leader>lc",
        function()
          require("snacks").picker.lazy()
        end,
        desc = "Lazy Config",
      },
      {
        "<leader>lpa",
        function()
          require("snacks").picker.picker_actions()
        end,
        desc = "Actions",
      },
      {
        "<leader>lpf",
        function()
          require("snacks").picker.picker_format()
        end,
        desc = "Format",
      },
      {
        "<leader>lpl",
        function()
          require("snacks").picker.picker_layouts()
        end,
        desc = "Layouts",
      },
      {
        "<leader>lpp",
        function()
          require("snacks").picker.picker_preview()
        end,
        desc = "Preview",
      },
      {
        "<leader>sd",
        function()
          require("snacks").picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
    },
  },
}
