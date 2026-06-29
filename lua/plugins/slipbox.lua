-- Source the slipbox directory from the domain module so there is a single
-- definition (also used as its pre-setup fallback). require() here only loads
-- the pure module; the plugin's setup() -- which creates the user commands and
-- the save autocmd -- still runs lazily from `config`, so it stays deferred.
local slipbox = require("user.slipbox")
local slipbox_dir = slipbox.default_slipbox_dir

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
      -- Find-slip picker. Lives on the slipbox spec (not the snacks spec) so
      -- pressing it loads slipbox -> runs setup() before the picker's finder
      -- resolves slip paths. snacks is eager-loaded, so the "slipbox" source
      -- (registered in pickers/slips.lua) already exists when this fires.
      {
        "<leader>sn",
        function()
          Snacks.picker.pick({ source = "slipbox" })
        end,
        desc = "Find Slip",
      },
    },
    config = function()
      slipbox.setup({
        slipbox_dir = slipbox_dir,
      })
    end,
  },
}
