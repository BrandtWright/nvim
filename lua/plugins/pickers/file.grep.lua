return {
  {
    -- Group names
    {
      "folke/which-key.nvim",
      opts = {
        spec = {
          { "<leader>r", group = "Grep" },
        },
      },
    },

    -- Standard grep
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>/", false }, -- grep is in <leader>rr
      {
        "<leader>rr",
        function()
          local opts = {
            vimgrep_arguments = {
              "rg",
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
              "--smart-case",
            },
            prompt_title = "Ripgrep",
          }
          require("telescope.builtin").live_grep(opts)
        end,
      },
    },
  },
}
