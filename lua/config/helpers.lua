local M = {}

M.toggle_terminal = function()
  if not pcall(require, "lazyvim") then
    require("user.notification.api").warn("LazyVim has not been loaded", "", "Lazy Helpers")
  end
  if vim.bo.buftype == "terminal" then
    vim.cmd("hide")
  else
    Snacks.terminal.toggle("bash", {
      cwd = vim.fn.getcwd(),
      win = {
        border = "single",
        style = "terminal",
        relative = "editor",
        width = 120,
        height = 25,
      },
    })
  end
end

return M
