local c = require("bw.config.colors")
local highlights = require("bw.config.highlights")
highlights.register({

  { name = "Todo", fg = c.green, bg = c.terminal, styles = {} },
  { name = "TodoSignTODO", fg = c.green, bg = c.terminal, styles = {} },

  { name = "MiniIndentscopeSymbol", fg = c.gold, bg = nil, styles = {} }, --   Animations between squirely braces

  { name = "WhichKeyFloat", bg = c.terminal },
  { name = "WhichKeyBorder", fg = c.brown },
  { name = "WhichKey", fg = c.white },
  { name = "WhichKeyGroup", fg = c.orange },
  { name = "WhichKeyDesc", fg = c.gold },
})

return {
  {
    "folke/todo-comments.nvim",
  },
  {
    "echasnovski/mini.indentscope",
  },
  {
    "norcalli/nvim-colorizer.lua",
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "single",
        height = 0.8,
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        -- add a border to hover docs and signature help
        lsp_doc_border = "single",
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      exclude = {
        filetypes = {
          "markdown",
          "dashboard",
          "snacks_dashboard",
          "Fm",
          "terminal",
          "lazyterm",
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.preset = "clasic"

      -- Window
      opts.win = opts.win or {}
      opts.win.border = "rounded"
      opts.win.no_overlap = false
      opts.win.width = 1000

      -- Icons
      opts.icons = opts.icons or {}
      opts.icons.group = ""
      opts.icons.mappings = false -- Don't use keymap icons in which-key menu

      -- Layout
      opts.layout = opts.layout or {}
      opts.layout.align = "center"
      opts.layout.spacing = 5

      -- Plugins
      opts.plugins = opts.plugins or {}
      opts.plugins.spelling = false

      -- Always group (even when there is only one keymap)
      opts.expand = 0

      opts.spec = {
        { "<leader>a", group = "AI" },
        { "<leader>ac", group = "ChatGPT" },
        { "<leader>b", group = "Buffer" },
        { "<leader>bs", group = "Scratch Buffers" },
        { "<leader>c", group = "Code" },
        { "<leader>e", group = "Explore" },
        { "<leader>f", group = "Find" },
        { "<leader>fg", group = "Git Objects" },
        { "<leader>g", group = "Git" },
        { "<leader>gb", group = "Buffer", mode = { "n", "v" } },
        { "<leader>gd", group = "Diff" },
        { "<leader>gh", group = "Hunk" },
        { "<leader>gm", group = "Blame" },
        { "<leader>gt", group = "Toggle" },
        { "<leader>h", group = "Harpoon" },
        { "<leader>o", group = "Open" },
        { "<leader>q", group = "Session" },
        { "<leader>r", group = "Grep" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Tabs" },
        { "<leader>u", group = "UI" },
        { "<leader>ud", group = "Diagnostics" },
        { "<leader>uz", group = "Toggle Zen Mode" },
        { "<leader>ug", group = "Git" },
        { "<leader>w", group = "Window" },
        { "<leader>x", group = "Lists" },
        { "<leader>z", group = "Slipbox" },
        { "g", group = "Goto" },
        { "gs", group = "Surround" },
      }
    end,
  },
}
