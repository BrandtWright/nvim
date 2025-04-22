--------------------------------------------------------------------------------
-- Indent
--------------------------------------------------------------------------------
local helpers = require("config.helpers")
return {
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        cwd = vim.fn.getcwd(),
        win = {
          border = "single",
          style = "terminal",
          relative = "editor",
          width = 120,
          height = 25,
          backdrop = false,
        },
      },
    },
    keys = {
      {
        "<leader>m",
        function()
          Snacks.terminal.toggle("bash")
        end,
        desc = "Toggle Floating Terminal",
        mode = { "n", "t" },
      },
      {
        "<c-_>",
        function()
          Snacks.terminal.toggle("bash")
        end,
        desc = "Toggle Floating Terminal",
      },
    },
  },
}
