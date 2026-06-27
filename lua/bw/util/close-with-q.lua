local M = {}

--- Maps buffer-local `q` to close the window for the given filetypes.
---
--- Intended for transient, read-only buffers (help, quickfix, fugitive-style
--- panels, plugin output windows, etc.). It mirrors the LazyVim built-in
--- `close_with_q` behavior so you can extend it to your own filetypes.
---
--- Note: this is for NORMAL buffers. Terminal-backed file managers (e.g.
--- fm-nvim) run in terminal-insert mode and manage their own teardown, so a
--- normal-mode `q` will not fire there and force-closing their buffer can make
--- the plugin error on its own exit handler. Don't list terminal filetypes.
---
---@param filetypes string[] Filetypes that should close on `q`
function M.setup(filetypes)
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("BwCloseWithQ", { clear = true }),
    pattern = filetypes,
    callback = function(ev)
      vim.keymap.set("n", "q", function()
        -- Close the window; if it's the last one, wipe the buffer instead so
        -- `q` still does something sensible rather than erroring.
        if not pcall(vim.cmd, "close") then
          vim.cmd("bdelete")
        end
      end, {
        buffer = ev.buf,
        silent = true,
        nowait = true,
        desc = "Close window",
      })
    end,
  })
end

return M
