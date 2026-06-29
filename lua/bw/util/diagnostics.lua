local M = {}

--- Builds the Snacks toggle config for diagnostic virtual_text. Kept pure (no
--- Snacks or keymap side effects) so it can be unit-tested in isolation; the
--- caller does the Snacks.toggle.new(...):map(...) wiring.
---
--- The toggle remembers the configured virtual_text value (often a table, e.g.
--- { prefix = "●" }) so toggling off and back on restores it instead of
--- collapsing it to a bare boolean.
---@return snacks.toggle.Opts
M.virtual_text_toggle = function()
  local saved_virtual_text = true
  return {
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
end

return M
