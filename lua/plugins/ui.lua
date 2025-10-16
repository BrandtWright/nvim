return {
  {
    "norcalli/nvim-colorizer.lua",
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "single",
        height = 0.8,
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      styles = {
        news = {
          backdrop = false,
          border = "single",
        },
        float = {
          backdrop = false,
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = function()
      Snacks.toggle.zoom():map("<leader>wm")
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        -- add a border to hover docs and signature help
        lsp_doc_border = "single",
      },
    },
    keys = {
      -- silly keys
      { "<leader>sna", false },
      { "<leader>snd", false },
      { "<leader>snh", false },
      { "<leader>snl", false },
      { "<leader>snt", false },
      { "<leader>sn", false },

      -- stylua: ignore
      { "<leader>sNn", function() Snacks.picker.notifications() end, desc = "Notifications", },
      { "<leader>sNa", "<cmd>NoiceAll<cr>", desc = "All", mode = "n" },
      { "<leader>sNd", "<cmd>NoiceDismiss<cr>", desc = "Dismiss All", mode = "n" },
      { "<leader>sNh", "<cmd>NoiceHistory<cr>", desc = "History", mode = "n" },
      { "<leader>sNl", "<cmd>NoiceLast<cr>", desc = "Last", mode = "n" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      local apply_highlights = function()
        vim.cmd("hi! link WhichKey Normal")
        vim.cmd("hi! link WhichKeyGroup Orange")
        vim.cmd("hi! link WhichKeyDesc Normal")
        vim.cmd("hi! link WhichKeyFloat Normal")
        vim.cmd("hi! link WhichKeyBorder FloatBorder")
      end

      apply_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("WhichKeyHighlights", { clear = true }),
        pattern = "*",
        callback = apply_highlights,
        desc = "Reapply which-key highlight groups after colorscheme changes",
      })

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
          { "<leader>f", group = "Find" },
          { "<leader>fg", group = "Git Objects" },
          { "<leader>g", group = "Git" },
          { "<leader>gb", group = "Buffer", mode = { "n", "v" } },
          { "<leader>gc", group = "Commits" },
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
          { "<leader>sN", group = "Noice" },
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
