-------------------------------------------------------------------------------
-- Fuzzy find over workspace symbols
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sS", Snacks.picker.lsp_workspace_symbols, desc = "Workspace Symbols" },
    },
  },
}
