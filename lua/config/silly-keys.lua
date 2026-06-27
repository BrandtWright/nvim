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
    { lhs = "<leader>ub", modes = { "n" } }, -- light/dark mode
    { lhs = "<leader>ud", modes = { "n" } }, -- toggle diagnostics is in leader.
    { lhs = "<leader>uZ", modes = { "n" } }, -- leader_w_m is convenient enough.

    -- Status
    { lhs = "<leader>l", modes = { "n" } }, -- lazy status
    { lhs = "<leader>L", modes = { "n" } }, -- lazy changelog
  },
}

return sillyKeyConfig.keys
