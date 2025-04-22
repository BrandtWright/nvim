return {
  {
    "LazyVim/LazyVim",
    opts = function()
      vim.cmd("hi! link LazyDimmed Comment")
    end,
    keys = {
      {
        "<esc><esc>",
        "<c-\\><c-n>",
        desc = "Enter Normal Mode",
        mode = { "t" },
      },
      {
        "<leader>ls",
        function()
          vim.cmd("Lazy")
        end,
        desc = "Lazy.nvim Status",
      },
      {
        "<leader>ll",
        function()
          LazyVim.news.changelog()
        end,
        desc = "Lazy Log",
      },
      {
        "<leader>lc",
        function()
          require("snacks").picker.lazy()
        end,
        desc = "Lazy Config",
      },
      {
        "<leader>or",
        function()
          local proj_root = LazyVim.root.get()
          if not proj_root or proj_root == "" then
            vim.notify("Could not determine project root directory", vim.log.levels.ERROR)
            return
          end
          local is_windows = vim.uv.os_uname().version:match("Windows")
          local path_separator = is_windows and "\\" or "/"
          local readme_path = proj_root .. path_separator .. "README.md"
          vim.cmd("edit " .. readme_path)
        end,
        desc = "Readme File",
      },
    },
  },
  -- Blacklist
  { "akinsho/bufferline.nvim", enabled = false },
  { "vim-illuminate", enabled = false },
  { "folke/flash.nvim", enabled = false },
  { "ibhagwan/fzf-lua", enabled = false },
  { "nvim-pack/nvim-spectre", enabled = false },
  { "MagicDuck/grug-far.nvim", enabled = false },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>fe", false },
      { "<leader>fE", false },
      { "<leader>e", false },
      { "<leader>E", false },
    },
  },
}
