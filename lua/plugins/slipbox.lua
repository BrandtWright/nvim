return {
  {
    dir = vim.fn.stdpath("config") .. "/lua/user/slipbox",
    cmd = { "SlipFind", "SlipNew", "SlipEdit" },
    dependencies = {
      "folke/snacks.nvim",
    },
    name = "slipbox", -- Optional: helps with module resolution
    keys = {
      {
        "<leader>zf",
        function()
          vim.cmd("SlipFind")
        end,
        desc = "Find slip",
      },
      {
        "<leader>zn",
        function()
          vim.cmd("SlipNew")
        end,
        desc = "New Slip",
      },
      {
        "<leader>ze",
        function()
          local input = vim.fn.input({ prompt = "Enter note title: " })
          if input ~= "" then
            vim.cmd("SlipEdit " .. input)
          end
        end,
        desc = "New Slip",
      },
    },
    config = function()
      require("user.slipbox").setup({
        slipbox_dir = vim.fn.expand("~/data/base/slipbox"),
      })
    end,
  },
}
