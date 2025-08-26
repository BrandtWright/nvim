return {
  {
    "folke/snacks.nvim",
    opts = function()
      local toggle_config = {
        id = "diagnostic_virtual_text",
        name = "Diagnostic Virtual Text",
        get = function()
          return vim.diagnostic.config().virtual_text
        end,
        set = function(state)
          local current = vim.diagnostic.config()
          current.virtual_text = state
          vim.diagnostic.config(current)
        end,
      }
      Snacks.toggle.new(toggle_config):map("<leader>udv")
      Snacks.toggle.diagnostics():map("<leader>udd")
    end,
  },
}
