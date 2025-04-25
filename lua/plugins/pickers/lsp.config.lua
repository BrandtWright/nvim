-------------------------------------------------------------------------------
-- Fuzzy find over lsp configuration
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sgl", Snacks.picker.lsp_config, desc = "Lsp Configuration" },
    },
  },
}
