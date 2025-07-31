return {
  {
    dir = vim.fn.stdpath("config") .. "/lua/user/slipbox",
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = { "SlipFind", "SlipNew", "SlipEdit" },
    name = "slipbox", -- Optional: helps with module resolution
    keys = {
      {
        "<leader>sn",
        function()
          vim.cmd("SlipFind")
        end,
        desc = "Find slip",
      },
      {
        "<leader>on",
        function()
          vim.cmd("SlipNew")
        end,
        desc = "New Slip",
      },
      {
        "<leader>oN",
        function()
          local input = vim.fn.input({ prompt = "Enter note title: " })
          if input ~= "" then
            vim.cmd("SlipEdit " .. input)
          end
        end,
        desc = "Edit Slip by ID",
      },
    },
    config = function()
      require("user.slipbox").setup({
        slipbox_dir = vim.fn.expand("~/data/base/slipbox"),
      })
    end,
  },
}
