-------------------------------------------------------------------------------
-- Fuzzy find nvim options
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>so", require("telescope.builtin").vim_options, desc = "Neovim options" },
    },
  },
}
