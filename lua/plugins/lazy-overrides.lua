local highlights = require("bw.util.highlights")

return {
  {

    -- Pined to version 1.0 (2.0 was a breaking change).
    -- Update when dependent plugins support the proper public interface
    -- See: https://github.com/LazyVim/LazyVim/issues/6039
    -- { "mason-org/mason.nvim", version = "^1.0.0" },
    -- { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },

    "LazyVim/LazyVim",
    opts = function()
      highlights.on_colorscheme("LazyVimHighlights", function()
        vim.cmd("hi! link LazyDimmed Comment")
        vim.cmd("hi! link LazyProp Label")
      end)
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
          Snacks.picker.lazy()
        end,
        desc = "Lazy Config",
      },
      {
        "<leader>or",
        function()
          local readme = vim.fs.joinpath(LazyVim.root(), "README.md")
          -- `{ args = { path } }` fnameescapes the path, so spaces/special chars are safe.
          vim.cmd.edit({ args = { readme } })
        end,
        desc = "Readme File",
      },
    },
  },
  -- plenary is required by after/plugin/globals.lua's RELOAD helper. It used to
  -- be pulled in transitively by telescope; declare it explicitly so the helper
  -- keeps working regardless of telescope's presence.
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Blacklist
  { "akinsho/bufferline.nvim", enabled = false },
  { "RRethy/vim-illuminate", enabled = false },
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
