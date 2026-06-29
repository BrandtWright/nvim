local M = {}
--- Utility to get color values
---@param group string
---@param attr string
---@return string? hex `#rrggbb` for the attribute, or nil if the group/attr is unset
M.get_attribute = function(group, attr)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  if hl and type(hl[attr]) == "number" then
    return string.format("#%06x", hl[attr])
  end
end

--- Applies `fn` now and re-applies it on every colorscheme change.
---
--- Plugin highlight overrides (forced `hi! link ...` or computed `nvim_set_hl`)
--- are wiped whenever a colorscheme is sourced, so they must be re-applied on the
--- ColorScheme event to persist across colorscheme switches. This wraps that
--- apply-now-plus-autocmd boilerplate.
---
--- The augroup is cleared on each registration, so calling this more than once
--- with the same `augroup` never accumulates duplicate autocmds.
---@param augroup string Unique augroup name for this set of highlights
---@param fn fun() Applies the highlight overrides
M.on_colorscheme = function(augroup, fn)
  fn()
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup(augroup, { clear = true }),
    pattern = "*",
    callback = fn,
    desc = "Reapply " .. augroup .. " after colorscheme changes",
  })
end

return M
