return {
  {
    "LazyVim/LazyVim",
    keys = {
      -- silly key: disable default mapping for live_grep
      { "<leader>/", false },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
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
        desc = "From CWD",
      },
    },
  },
}
