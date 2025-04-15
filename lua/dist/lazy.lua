return {
  {
    "LazyVim/LazyVim",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "LazyNormal", fg = nil, bg = c.terminal, styles = {} },
        { name = "LazySpecial", fg = c.gold, bg = c.terminal, styles = {} },
        { name = "LazyReasonPlugin", fg = c.green, bg = c.terminal, styles = {} },
      })
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
