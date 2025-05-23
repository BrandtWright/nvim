return {
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
      vim.cmd("hi! link WhichKey Normal")
      vim.cmd("hi! link WhichKeyGroup Orange")
      vim.cmd("hi! link WhichKeyDesc Normal")
      vim.cmd("hi! link WhichKeyFloat Normal")
      vim.cmd("hi! link WhichKeyBorder FloatBorder")

      local my_opts = {

        preset = "clasic",
        win = {
          border = "rounded",
          no_overlap = false,
          width = 1000,
        },
        icons = {
          -- Don't use icon/prefix for which-key groups
          group = "",
          -- Don't use keymap icons in which key menu
          mappings = false,
        },
        layout = {
          align = "center",
          spacing = 5,
        },
        plugins = {
          -- Donn't use which-key for spelling suggestions
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
          { "<leader>d", group = "Debug" },
          { "<leader>dp", group = "Profiler" },
          { "<leader>e", group = "Explore" },
          { "<leader>fg", group = "Git Objects" },
          { "<leader>g", group = "Git" },
          { "<leader>gb", group = "Buffer", mode = { "n", "v" } },
          { "<leader>gd", group = "Diff" },
          { "<leader>gh", group = "Hunk" },
          { "<leader>gm", group = "Blame" },
          { "<leader>gt", group = "Toggle" },
          { "<leader>h", group = "Harpoon" },
          { "<leader>i", group = "Insert" },
          { "<leader>l", group = "Lazy" },
          { "<leader>lp", group = "Picker" },
          { "<leader>m", group = "Terminal" },
          { "<leader>o", group = "Open" },
          { "<leader>os", group = "Persistant Scratch Pad" },
          { "<leader>oS", group = "Temporary Scratch Pad" },
          { "<leader>q", group = "Session" },
          { "<leader>r", group = "Grep" },
          { "<leader>s", group = "Search" },
          { "<leader>sg", group = "Config" },
          { "<leader>sr", group = "Resume" },
          { "<leader>t", group = "Tabs" },
          { "<leader>u", group = "UI" },
          { "<leader>ud", group = "Diagnostics" },
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
