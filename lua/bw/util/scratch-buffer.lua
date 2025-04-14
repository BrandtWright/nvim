local M = {}

M.open_or_create = function()
  local scratch_buf_name = "__scratch_markdown__"

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf):match(scratch_buf_name .. "$") then
      vim.api.nvim_set_current_buf(buf)
      return
    end
  end
  -- Create a new unlisted buffer to avoid name conflict
  local buf = vim.api.nvim_create_buf(false, true) -- listed=false, scratch=false
  vim.api.nvim_buf_set_name(buf, scratch_buf_name)

  -- Set buffer options
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = "markdown"
  vim.bo[buf].bufhidden = "hide"

  -- Insert "# Scratch Pad" as the first line
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "# Scratch Pad", "" })

  -- Show buffer in current window
  vim.api.nvim_set_current_buf(buf)
end

return M
