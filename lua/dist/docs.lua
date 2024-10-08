local M = {}

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

return M
