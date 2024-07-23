local M = {}

M.isAvailable = function(moduleName)
  local hasModule = pcall(require, moduleName)
  if not hasModule then
    local message = string.format("module '%s' could not be found.", moduleName)
    vim.notify(message, vim.log.levels.WARN, { title = "bw.util.module", icon = "⚠️" })
    return
  end
  return hasModule
end

return M
