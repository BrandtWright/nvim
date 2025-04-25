-------------------------------------------------------------------------------
-- Fuzzy find over document synbols
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>ss", Snacks.picker.lsp_symbols, desc = "Document Symbols" },
    },
  },
}
