return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: disable default mapping for live_grep
      { "<leader>/", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>rr",
        function()
          Snacks.picker.grep()
        end,
        desc = "From CWD",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "From CWD",
      },
      {
        "<leader>rt",
        function()
          local file_type = vim.fn.input("Type: ")
          if file_type and file_type ~= "" then
            Snacks.picker.grep({
              file_type = file_type,
            })
          end
        end,
        desc = "File Type",
      },
      {
        "<leader>rl",
        function()
          local dir = vim.fn.input("Directory: ", "", "dir")
          if dir and dir ~= "" then
            Snacks.picker.grep({ dirs = { dir } })
          end
        end,
        desc = "From Location",
      },
      {
        "<leader>rs",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "String",
      },
    },
  },
}
