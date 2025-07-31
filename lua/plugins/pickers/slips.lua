-------------------------------------------------------------------------------
-- Fuzzy find over key maps
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    dependencies = {
      name = "slipbox",
      dir = vim.fn.stdpath("config") .. "/lua/user/slipbox",
    },
    cmd = { "SlipFind" },
    opts = function(_, opts)
      return opts
    end,
    keys = {
      {
        "<leader>zz",
        function()
          local slipbox = require("user.slipbox")
          vim.notify(slipbox.get_slipbox_path())
        end,
        desc = "Find Slip",
      },
    },
  },
}
