---@class SillyKey
---@field lhs string
---@field modes string[]

---@class SillyKeysConfig
---@field keys SillyKey[]
local sillyKeyConfig = {
  keys = {
    -- Window Navigation
    { lhs = "<C-h>", modes = { "n" } },
    { lhs = "<C-j>", modes = { "n" } },
    { lhs = "<C-k>", modes = { "n" } },
    { lhs = "<C-l>", modes = { "n" } },

    -- Buffers
    { lhs = "<leader>`", modes = { "n" } },
    { lhs = "<leader>bb", modes = { "n" } },

    -- Search
    { lhs = "n", modes = { "n", "x", "o" } },
    { lhs = "N", modes = { "n", "x", "o" } },

    -- Floating Terminal
    { lhs = "<leader>fT", modes = { "n" } },

    -- tabs
    { lhs = "<leader><tab>l", modes = { "n" } },
    { lhs = "<leader><tab>f", modes = { "n" } },
    { lhs = "<leader><tab><tab>", modes = { "n" } },
    { lhs = "<leader><tab>]", modes = { "n" } },
    { lhs = "<leader><tab>d", modes = { "n" } },
    { lhs = "<leader><tab>[", modes = { "n" } },
    { lhs = "<leader><tab>o", modes = { "n" } },

    -- Toggles
    { lhs = "<leader>ud", modes = { "n" } }, -- diagnostics
    { lhs = "<leader>ub", modes = { "n" } }, -- light/dark mode
    { lhs = "<leader>uc", modes = { "n" } }, -- conceal

    -- Finders
    { lhs = "<leader>fr", modes = { "n" } }, -- Recent Files (Root)
    { lhs = "<leader>fR", modes = { "n" } }, -- Recent Files (CWD)
    { lhs = "<leader>sg", modes = { "n" } }, -- Grep (Root)
    { lhs = "<leader>sG", modes = { "n" } }, -- Grep (CWD)
    { lhs = "<leader>sw", modes = { "n" } }, -- Find files matching word or visual selectino (Root)
    { lhs = "<leader>sW", modes = { "n" } }, -- Find files matching word or visual selectino (CWD)

    -- Status
    { lhs = "<leader>l", modes = { "n" } }, -- lazy status
    { lhs = "<leader>L", modes = { "n" } }, -- lazy changelog
  },
}

return sillyKeyConfig.keys
