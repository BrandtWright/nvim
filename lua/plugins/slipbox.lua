local slipbox_dir = vim.fn.expand("~/data/base/slipbox")

return {
  {
    name = "slipbox", -- Optional: helps with module resolution
    dir = vim.fn.stdpath("config") .. "/lua/user/slipbox",
    cmd = { "SlipNew", "SlipEdit" },
    -- Also load when a slip README is opened directly (e.g. from the slips
    -- picker), so the BufWriteCmd that routes :w through `snote` is registered
    -- before the buffer can be written. Pattern mirrors the save autocmd.
    event = { "BufReadPre " .. slipbox_dir .. "/*/README.md" },
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
        slipbox_dir = slipbox_dir,
      })
    end,
  },
}
