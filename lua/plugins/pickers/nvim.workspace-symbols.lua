-------------------------------------------------------------------------------
-- Fuzzy find over icons
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sS", Snacks.picker.lsp_workspace_symbols, desc = "Workspace Symbold" },
    },
  },
}
