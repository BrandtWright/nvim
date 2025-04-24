return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>f.",
        function()
          local pickers = require("telescope.pickers")
          local conf = require("telescope.config").values
          local locs = vim.fn.systemlist("/home/brandt/.local/bin/dotfiles")
          pickers
            .new({}, {
              prompt_title = "Find Files (Dotfiles)",
              finder = require("telescope.finders").new_table(locs),
              sorter = conf.file_sorter({}),
              previewer = conf.file_previewer({}),
            })
            :find()
        end,
        desc = "Files (Home Directory)",
      },
    },
  },
}
