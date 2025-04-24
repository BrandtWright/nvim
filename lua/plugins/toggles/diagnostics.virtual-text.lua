return {
  {
    "folke/snacks.nvim",
    opts = function()
      local toggle_config = {
        id = "diagnostic_virtual_text",
        name = "Diagnostic Virtuaal Text",
        get = function()
          return vim.diagnostic.config().virtual_text
        end,
        set = function(state)
          if state then
            local diagnostics = require("bw.util.diagnostics")
            local opts = diagnostics.get_default_opts()
            vim.diagnostic.config({ virtual_text = opts.virtual_text })
          else
            vim.diagnostic.config({ virtual_text = false })
          end
        end,
      }
      Snacks.toggle.new(toggle_config):map("<leader>udv")
    end,
  },
}
