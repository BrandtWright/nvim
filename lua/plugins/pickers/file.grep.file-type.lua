return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>rt",
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
              "--type",
              vim.fn.input("Type: "),
            },
          }
          require("telescope.builtin").live_grep(opts)
        end,
        desc = "File Type",
      },
    },
  },
}
