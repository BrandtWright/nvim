return {
  {
    "folke/todo-comments.nvim",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "Todo", fg = c.green, bg = c.terminal, styles = {} },
        { name = "TodoSignTODO", fg = c.green, bg = c.terminal, styles = {} },
      })
    end,
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
    "folke/which-key.nvim",
    opts = function(_, opts)
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({

        -- Todos
        { name = "Todo", fg = c.green, bg = c.terminal, styles = {} },
        { name = "TodoSignTODO", fg = c.green, bg = c.terminal, styles = {} },

        -- Whichkey
        { name = "WhichKeyFloat", bg = c.terminal },
        { name = "WhichKeyBorder", fg = c.brown },
        { name = "WhichKey", fg = c.white },
        { name = "WhichKeyGroup", fg = c.orange },
        { name = "WhichKeyDesc", fg = c.gold },
      })

      local my_opts = {

        preset = "clasic",
        win = {
          border = "rounded",
          no_overlap = false,
          width = 1000,
        },
        icons = {
          group = "",
          mappings = false, -- Dont use keymap icons in which key menu
        },
        layout = {
          align = "center",
          spacing = 5,
        },
        plugins = {
          spelling = false,
        },
        expand = 0,
        spec = {
          { "<leader>a", group = "AI" },
          { "<leader>ac", group = "ChatGPT" },
          { "<leader>b", group = "Buffer" },
          { "<leader>by", group = "Yank" },
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
          { "<leader>l", group = "Lazy" },
          { "<leader>lp", group = "Picker" },
          { "<leader>m", group = "Terminal" },
          { "<leader>o", group = "Open" },
          { "<leader>q", group = "Session" },
          { "<leader>r", group = "Grep" },
          { "<leader>s", group = "Search" },
          { "<leader>t", group = "Tabs" },
          { "<leader>u", group = "UI" },
          { "<leader>ud", group = "Diagnostics" },
          { "<leader>uz", group = "Toggle Zen Mode" },
          { "<leader>w", group = "Window" },
          { "<leader>x", group = "Lists" },
          { "<leader>z", group = "Slipbox" },
          { "g", group = "Goto" },
          { "gs", group = "Surround" },
        },
      }
      return vim.tbl_deep_extend("force", opts or {}, my_opts)
    end,
  },
}
