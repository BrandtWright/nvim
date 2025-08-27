-------------------------------------------------------------------------------
-- Fuzzy find over lsp configuration
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>sgl", function() Snacks.picker.lsp_config() end, desc = "Lsp Configuration", },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "Document Symbols", },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols", },
    },
  },
}
