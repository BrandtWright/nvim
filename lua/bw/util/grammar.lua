local M = {}

--- Builds the Snacks toggle config for the harper_ls grammar checker. Kept pure
--- (no Snacks or keymap side effects) so it can be unit-tested in isolation; the
--- caller does the Snacks.toggle.new(...):map(...) wiring.
---@return snacks.toggle.Opts
M.checker_toggle = function()
  return {
    id = "grammar_checker",
    name = "Grammar Checker",
    get = function()
      return #vim.lsp.get_clients({ name = "harper_ls", bufnr = 0 }) > 0
    end,
    set = function(state)
      if state then
        vim.lsp.enable("harper_ls")
        -- re-fire FileType so harper_ls attaches to the current buffer now
        vim.api.nvim_exec_autocmds("FileType", { buffer = 0, modeline = false })
      else
        for _, client in ipairs(vim.lsp.get_clients({ name = "harper_ls" })) do
          client:stop()
        end
        vim.lsp.enable("harper_ls", false)
      end
    end,
  }
end

return M
