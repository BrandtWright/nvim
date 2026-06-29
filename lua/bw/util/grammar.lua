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
      -- Global scope to match `set`: disabling stops every harper_ls client and
      -- runs `vim.lsp.enable(false)` globally, so the reported state must be
      -- global too (a per-buffer check would disagree with the toggle's effect).
      return #vim.lsp.get_clients({ name = "harper_ls" }) > 0
    end,
    set = function(state)
      if state then
        vim.lsp.enable("harper_ls")
        -- Re-fire FileType for every loaded buffer so harper_ls attaches to all
        -- open prose buffers, not just the focused one (vim.lsp.enable only
        -- registers the config; attachment happens on the FileType event). The
        -- re-run of other FileType handlers is idempotent setlocal work.
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) then
            vim.api.nvim_exec_autocmds("FileType", { buffer = buf, modeline = false })
          end
        end
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
