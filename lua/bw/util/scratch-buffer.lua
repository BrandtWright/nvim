local M = {}

---@param mode "split" | "vsplit" | "current_window" | "popup"
M.open_scratch_buffer = function(mode)
  local scratch_buf_name = "__scratch_markdown__"
  local buf

  -- Search for existing scratch buffer
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(b):match(scratch_buf_name .. "$") then
      buf = b
      break
    end
  end

  -- Create buffer if not found
  if not buf or not vim.api.nvim_buf_is_valid(buf) then
    buf = vim.api.nvim_create_buf(false, true) -- unlisted scratch buffer
    vim.api.nvim_buf_set_name(buf, scratch_buf_name)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].swapfile = false
    vim.bo[buf].filetype = "markdown"
    vim.bo[buf].bufhidden = "hide"
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "# Scratch Pad", "" })
  end

  -- remove keymap for delete buffer
  vim.keymap.set("n", "<leader>bd", function()
    vim.notify("Cannot delete scratch buffer")
  end, { buffer = buf, silent = true })

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
    -- Check if already open in a floating window
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == buf then
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

    -- local original_win = vim.api.nvim_get_current_win()
    local float_win = vim.api.nvim_open_win(buf, true, win_opts)

    -- 'q' closes just the popup
    vim.keymap.set("n", "q", function()
      if vim.api.nvim_win_is_valid(float_win) then
        vim.api.nvim_win_close(float_win, true)
      end
    end, { buffer = buf, silent = true })
  else
    vim.notify("Invalid mode for scratch buffer: " .. tostring(mode), vim.log.levels.ERROR)
  end
end

return M
