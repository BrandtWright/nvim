return {
  {
    dir = vim.fn.stdpath("config") .. "/lua/user/slipbox",
    dependencies = {
      "folke/snacks.nvim",
    },
    name = "slipbox", -- Optional: helps with module resolution
    config = function()
      require("user.slipbox").setup({
        slipbox_dir = "~/data/base/slipbox",
      })
    end,
  },
}
