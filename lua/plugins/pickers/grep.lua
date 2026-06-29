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
          require("bw.util.pick").with_input("Type: ", nil, function(ft)
            Snacks.picker.grep({ ft = ft })
          end)
        end,
        desc = "File Type",
      },
      {
        "<leader>rl",
        function()
          require("bw.util.pick").with_input("Directory: ", "dir", function(dir)
            Snacks.picker.grep({ dirs = { dir } })
          end)
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
