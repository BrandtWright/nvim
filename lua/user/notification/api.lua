local M = {}

--- Info toaster
---@param msg string
---@param icon string
---@param title string
M.info = function(msg, icon, title)
  vim.notify(msg, vim.log.levels.INFO, { title = title, icon = icon })
end

--- Warn toaster
---@param msg string
---@param icon string
---@param title string
M.warn = function(msg, icon, title)
  vim.notify(msg, vim.log.levels.WARN, { title = title, icon = icon })
end

---Error toaster
---@param msg string
---@param icon string
---@param title string
M.error = function(msg, icon, title)
  vim.notify(msg, vim.log.levels.ERROR, { title = title, icon = icon })
end

return M
