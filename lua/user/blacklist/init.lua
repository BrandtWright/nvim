return {

  ---------------------------------------------------------------
  -- Perf problems for large files
  -- { "echasnovski/mini.indentscope", enabled = false },
  -- { "lukas-reineke/indent-blankline.nvim", enabled = false },
  ---------------------------------------------------------------

  { "akinsho/bufferline.nvim", enabled = false },
  { "vim-illuminate", enabled = false },
  { "folke/flash.nvim", enabled = false },
  {
    "nvim-pack/nvim-spectre",
    enabled = false,
    -- { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ff", false }, -- Telescope->Grep instead of Telescope->OldFiles
      { "<leader>fr", false }, -- Telescope->Grep instead of Telescope->OldFiles
      { "<leader>fR", false }, -- Telescope->Grep instead of Telescope->OldFiles
      { "<leader>gs", false }, -- Fugitive->Status instead of Gitsigns->Status
      { "<leader>sg", false }, -- LazyVim/Util/telescope.lua grep
      { "<leader>sG", false }, -- LazyVim/Uil/telescope.lua grep
      { "<leader>sw", false }, -- LazyVim/Util/telescope.lua grep
      { "<leader>sW", false }, -- LazyVim/Util/telescope.lua grep
      { "<leader>sb", false }, -- Current Buffer Fuzzy Find is in <leader>f
      { "<leader>ss", false }, -- Lsp_ducument_symbols with lazy kind filter
      { "<leader>sS", false }, -- Lsp_workspace_symbols with lazy kind filter
      { "<leader>sd", false }, -- Diagnostics are in <leader>f
      { "<leader>sD", false }, -- Diagnostics are in <leader>f
      { "<leader>sC", false }, -- Commands are <leader>s:
      { "<leader>sR", false }, -- Resume is <leader>sr
      { "<leader>sm", false }, -- Override whichkey desc
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>fe", false },
      { "<leader>fE", false },
      { "<leader>e", false },
      { "<leader>E", false },
    },
  },
  {
    "LazyVim/LazyVim",
    keys = {
      -- General
      { "<C-h>", false }, -- Tmux Navigator
      { "<C-j>", false }, -- Tmux Navigator
      { "<C-k>", false }, -- Tmux Navigator
      { "<C-l>", false }, -- Tmux Navigator

      { "<leader>bb", false }, -- <C-^>

      { "<leader>w-", false }, -- <leader>ws
      { "<leader>w|", false }, -- <leader>wv
      { "<leader>_", false }, -- <leader>wv
      { "<leader>-", false }, -- <leader>wv
      { "<leader>|", false }, -- <leader>wv
      { "<leader>gs", false }, -- Fugitive->Status instead of Gitsigns->Status
    },
  },
}
