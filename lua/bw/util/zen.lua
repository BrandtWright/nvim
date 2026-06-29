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
    vim.o.laststatus = vim.g.zen_mode_last_status
    if tmux then
      os.execute("tmux set -g status " .. vim.g.zen_mode_tmux_status_bar)
    end
    vim.g.zen_mode = false
  else -- save state and turn things off
    vim.g.zen_mode_last_status = vim.o.laststatus
    vim.o.laststatus = 0
    if tmux then
      vim.g.zen_mode_tmux_status_bar = vim.trim(vim.fn.system("tmux show -gv status"))
      os.execute("tmux set -g status off")
    end
    vim.g.zen_mode = true
  end
end

return M
