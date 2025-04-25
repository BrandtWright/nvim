-------------------------------------------------------------------------------
-- Fuzzy find over icons
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>ss", Snacks.picker.lsp_symbols, desc = "Document Symbols" },
    },
  },
}
