--------------------------------------------------------------------------------
-- Indent
--------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
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
        "<c-_>",
        function()
          Snacks.terminal.toggle("bash", { cwd = vim.fn.getcwd() })
        end,
        desc = "Toggle Floating Terminal",
      },
    },
  },
}
