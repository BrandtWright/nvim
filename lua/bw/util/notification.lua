local M = {}

--- Builds a toaster bound to a specific log level. The returned function takes
--- the message, an optional title (the notification's source/context, e.g.
--- "Slipbox"), and an optional icon. This is the standard notification entry
--- point for the config -- prefer it over calling `vim.notify` directly so
--- level, title, and icon are passed consistently.
---@param level integer A `vim.log.levels` value
---@return fun(msg: string, title?: string, icon?: string)
local function toaster(level)
  return function(msg, title, icon)
    vim.notify(msg, level, { title = title, icon = icon })
  end
end

M.info = toaster(vim.log.levels.INFO)
M.warn = toaster(vim.log.levels.WARN)
M.error = toaster(vim.log.levels.ERROR)

return M
