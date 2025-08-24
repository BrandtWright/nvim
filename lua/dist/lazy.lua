return {
  {

    -- Pined to version 1.0 (2.0 was a breaking change).
    -- Update when dependent plugins support the proper public interface
    -- See: https://github.com/LazyVim/LazyVim/issues/6039
    -- { "mason-org/mason.nvim", version = "^1.0.0" },
    -- { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },

    "LazyVim/LazyVim",
    opts = function()
      local apply_highlights = function()
        vim.cmd("hi! link LazyDimmed Comment")
        vim.cmd("hi! link LazyProp Label")
      end

      apply_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("LazyVimHighlights", { clear = true }),
        pattern = "*",
        callback = apply_highlights,
        desc = "Reapply LazyVim highlight groups after colorscheme changes",
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
      {
        "<leader>or",
        function()
          vim.cmd("edit " .. LazyVim.root() .. require("bw.util.os").path_seperator() .. "README.md")
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
