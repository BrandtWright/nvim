return {
  {
    "folke/snacks.nvim",
    opts = function()
      -- Remembers the configured virtual_text value (often a table, e.g.
      -- { prefix = "..." }) so toggling off and back on restores it instead of
      -- collapsing it to a bare boolean.
      local saved_virtual_text = true
      local toggle_config = {
        id = "diagnostic_virtual_text",
        name = "Diagnostic Virtual Text",
        get = function()
          return vim.diagnostic.config().virtual_text ~= false
        end,
        set = function(state)
          if state then
            vim.diagnostic.config({ virtual_text = saved_virtual_text })
          else
            local current = vim.diagnostic.config().virtual_text
            if current ~= false then
              saved_virtual_text = current
            end
            vim.diagnostic.config({ virtual_text = false })
          end
        end,
      }
      Snacks.toggle.new(toggle_config):map("<leader>udv")
      Snacks.toggle.diagnostics():map("<leader>udd")
    end,
  },
}
