return {
  {
    dir = vim.fn.stdpath("config") .. "/lua/user/slipbox",
    lazy = false,
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
    },
    config = function()
      require("user.slipbox").setup({
        slipbox_dir = vim.fn.expand("~/data/base/slipbox"),
      })
    end,
  },
}
