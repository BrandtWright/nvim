local M = {}

--- Builds a toaster bound to a specific log level.
---@param level integer A `vim.log.levels` value
---@return fun(msg: string, icon: string, title: string)
local function toaster(level)
  return function(msg, icon, title)
    vim.notify(msg, level, { title = title, icon = icon })
  end
end

--- Warn toaster
M.warn = toaster(vim.log.levels.WARN)

return M
