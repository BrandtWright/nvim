-- <leader>rr and <leader>/ are two bindings for the same action (grep from cwd).
local function grep_cwd()
  Snacks.picker.grep()
end

return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>rr", grep_cwd, desc = "From CWD" },
      { "<leader>/", grep_cwd, desc = "From CWD" },
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
