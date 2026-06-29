local M = {}

-- Note: buff_exceeds_size currently has no production caller. It was kept (and
-- unit-tested) after a former nvim-treesitter spec that tried to size-gate
-- highlighting via `highlight.disable = function(...) end` was removed: LazyVim
-- tracks nvim-treesitter's `main` branch where `highlight.disable` is a list of
-- languages (string[]), not a predicate, so that function never ran. Size-gated
-- treesitter would instead have to be wired through Snacks.bigfile (LazyVim's
-- big-file handler adjusts syntax/animation but does not stop treesitter). This
-- helper is the reusable size check for that future wiring.

--- Returns true if the file backing `buf` is larger than `max_size` bytes.
--- An unnamed buffer (or one whose file cannot be stat'd) is treated as not
--- exceeding the limit.
---@param buf integer Buffer handle
---@param max_size integer Size threshold in bytes
---@return boolean
M.buff_exceeds_size = function(buf, max_size)
  local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_size then
    return true
  end
  return false
end

return M
