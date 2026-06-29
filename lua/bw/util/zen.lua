-- Tmux-aware "zen mode": hide Neovim's statusline (laststatus = 0) and, when
-- running inside tmux, hide tmux's status bar too -- restoring both to their
-- prior values on the next toggle. The saved state lives in vim.g.zen_mode* so
-- the restore reads back exactly what was stashed when zen mode was enabled.

local M = {}

--- Toggle zen mode on or off.
--- Enabling saves the current laststatus (and, inside tmux, the tmux `status`
--- setting) before blanking them; disabling restores whatever was saved. The
--- tmux side effects are gated on $TMUX, so outside tmux the statusline behaviour
--- is self-contained -- no tmux server required, which also makes it testable.
function M.toggle()
  local tmux = os.getenv("TMUX")
  if vim.g.zen_mode then -- restore status bars
    -- `or 3` guards a missing stash (zen_mode set true by something other than
    -- this function): setting laststatus to nil would error. 0 is truthy in Lua,
    -- so a legitimately-saved 0 is preserved.
    vim.o.laststatus = vim.g.zen_mode_last_status or 3
    if tmux then
      -- Fall back to "on" when the saved value is missing/empty (e.g. the `tmux
      -- show` below failed when zen mode was enabled). Restoring with no argument
      -- ("tmux set -g status ") errors, and a visible status bar is the sane
      -- default.
      local status = vim.g.zen_mode_tmux_status_bar
      if status == nil or status == "" then
        status = "on"
      end
      os.execute("tmux set -g status " .. status)
    end
    vim.g.zen_mode = false
  else -- save state and turn things off
    vim.g.zen_mode_last_status = vim.o.laststatus
    vim.o.laststatus = 0
    if tmux then
      -- Default to "on" (the usual state) if the query fails or returns nothing,
      -- so the restore branch above never builds an argument-less `tmux set`.
      local out = vim.trim(vim.fn.system("tmux show -gv status"))
      vim.g.zen_mode_tmux_status_bar = (vim.v.shell_error == 0 and out ~= "") and out or "on"
      os.execute("tmux set -g status off")
    end
    vim.g.zen_mode = true
  end
end

return M
