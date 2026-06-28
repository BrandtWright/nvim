local M = {}

--- Builds a toaster bound to a specific log level.
---@param level integer A `vim.log.levels` value
---@return fun(msg: string, icon: string, title: string)
local function toaster(level)
  return function(msg, icon, title)
    vim.notify(msg, level, { title = title, icon = icon })
  end
end

--- Info toaster
M.info = toaster(vim.log.levels.INFO)

--- Warn toaster
M.warn = toaster(vim.log.levels.WARN)

--- Error toaster
M.error = toaster(vim.log.levels.ERROR)

return M
