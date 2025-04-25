-------------------------------------------------------------------------------
-- Fuzzy find over neovim plugin files
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>sgp",
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath("data") })
        end,
        desc = "Neovim Plugin File",
      },
    },
  },
}
