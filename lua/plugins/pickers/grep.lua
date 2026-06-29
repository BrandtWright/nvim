return {
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
              ft = file_type,
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
        desc = "Word / Selection",
        mode = { "n", "x" },
      },
      -- Grep lives under <leader>r; disable LazyVim's vestigial grep_word (cwd)
      -- default so it doesn't linger in the search namespace. (<leader>sw is
      -- repurposed for Dictionary in config/keymaps.lua.)
      { "<leader>sW", false, mode = { "n", "x" } },
    },
  },
}
