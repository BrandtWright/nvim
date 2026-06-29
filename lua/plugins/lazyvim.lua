-- Distribution-level configuration: things that shape the LazyVim distro itself
-- rather than any one bundled plugin -- LazyVim core tweaks (highlights, the
-- <leader>l* lazy-management maps), the explicit plenary dependency, and the
-- blacklist of bundled plugins we opt out of. Plugin-specific keymap overrides
-- live with that plugin's spec instead (e.g. neo-tree's are in navigation.lua).
local highlights = require("bw.util.highlights")

return {
  {
    "LazyVim/LazyVim",
    opts = function()
      highlights.on_colorscheme("LazyVimHighlights", function()
        vim.cmd("hi! link LazyDimmed Comment")
        vim.cmd("hi! link LazyProp Label")
      end)
    end,
    keys = {
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
}
