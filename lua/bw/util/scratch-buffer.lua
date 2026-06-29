local M = {}

local toast = require("bw.util.notification")

--- Opens or reuses a transient markdown scratch buffer in the requested mode.
--- The buffer is a single in-memory `nofile` buffer reused for the lifetime of
--- the Neovim session; it is NOT written to disk and does NOT survive a restart.
--- It is unlisted and `<leader>bd` is shadowed to prevent accidental deletion.
---@param mode "split" | "vsplit" | "current_window" | "popup" Display mode for the scratch buffer
M.open_scratch_buffer = function(mode)
  local scratch_buf_name = "__scratch_markdown__"
  local buf

  -- Find the existing scratch buffer by its identity tag, not its name -- a real
  -- file whose path ends in the scratch name would otherwise be mistaken for it.
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.b[b].bw_scratch then
      buf = b
      break
    end
  end

  -- Create buffer if not found
  if not buf or not vim.api.nvim_buf_is_valid(buf) then
    buf = vim.api.nvim_create_buf(false, true) -- unlisted scratch buffer
    vim.api.nvim_buf_set_name(buf, scratch_buf_name) -- display name only
    vim.b[buf].bw_scratch = true -- identity tag used to find/reuse this buffer
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].swapfile = false
    vim.bo[buf].filetype = "markdown"
    vim.bo[buf].bufhidden = "hide"
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "# Scratch Pad", "" })

    -- Shadow <leader>bd so the scratch buffer can't be deleted. Buffer-local, so
    -- it persists for the buffer's (session-long) lifetime -- set once here at
    -- creation rather than on every open call.
    vim.keymap.set("n", "<leader>bd", function()
      toast.warn("Cannot delete scratch buffer", "Scratch Buffer")
    end, { buffer = buf, silent = true })
  end

  -- Determine how to display the buffer
  if mode == "split" then
    vim.cmd("split")
    vim.api.nvim_set_current_buf(buf)
  elseif mode == "vsplit" then
    vim.cmd("vsplit")
    vim.api.nvim_set_current_buf(buf)
  elseif mode == "current_window" then
    vim.api.nvim_set_current_buf(buf)
  elseif mode == "popup" then
    -- Check if already open in a floating window. Match on float-ness too: the
    -- buffer is reused across modes, so without the `relative ~= ""` guard a
    -- copy showing in a split would short-circuit and no popup would open.
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == buf and vim.api.nvim_win_get_config(win).relative ~= "" then
        vim.api.nvim_set_current_win(win)
        return
      end
    end

    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.6)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local win_opts = {
      relative = "editor",
      row = row,
      col = col,
      width = width,
      height = height,
      style = "minimal",
      border = "rounded",
    }

    local float_win = vim.api.nvim_open_win(buf, true, win_opts)

    -- 'q' closes just the popup. Scoped to the float's lifetime: the buffer is
    -- reused across display modes, so a permanent buffer-local 'q' would shadow
    -- normal 'q' once the buffer is later shown in a split.
    vim.keymap.set("n", "q", function()
      if vim.api.nvim_win_is_valid(float_win) then
        vim.api.nvim_win_close(float_win, true)
      end
    end, { buffer = buf, silent = true })

    vim.api.nvim_create_autocmd("WinClosed", {
      pattern = tostring(float_win),
      once = true,
      callback = function()
        pcall(vim.keymap.del, "n", "q", { buffer = buf })
      end,
    })
  else
    toast.error("Invalid mode for scratch buffer: " .. tostring(mode), "Scratch Buffer")
  end
end

return M
