return {
  {
    name = "slipbox", -- Optional: helps with module resolution
    dir = vim.fn.stdpath("config") .. "/lua/user/slipbox",
    cmd = { "SlipNew", "SlipEdit" },
    keys = {
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
          local input = vim.fn.input({ prompt = "Slip ID:" })
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
