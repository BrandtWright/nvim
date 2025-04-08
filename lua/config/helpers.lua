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

M.try_edit_readme = function()
  local proj_root = LazyVim.root.get()

  if not proj_root or proj_root == "" then
    vim.notify("Could not determine project root directory", vim.log.levels.ERROR)
    return
  end

  -- TODO: Make the following code cross-platform by making the direcotry seperator conditional
  local readme_path = proj_root .. "/README.md"
  vim.cmd("edit " .. readme_path)
end

M.open_readme = function()
  local proj_root = LazyVim.root.get()
  vim.cmd("edit " .. proj_root .. "/README.md")
end

return M
