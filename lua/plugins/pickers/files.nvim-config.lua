-------------------------------------------------------------------------------
-- Fuzzy find over neovim config files
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: config file picker is handled by snacks
      { "<leader>fc", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      -- silly key: moved to leader_s_gc
      { "<leader>fc", false },
      {
        "<leader>sgc",
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Neovim Config File",
      },
    },
  },
}
