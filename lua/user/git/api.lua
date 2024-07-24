local icon = ""
local module_name = "user.git.api"

local warn = function(msg)
  local toaster = require("user.notification.api")
  toaster.warn(msg, icon, module_name)
end

local M = {}

--- Returns true if `cwd` is a git repository, else false with an error message
---@param path string: directory path
---@return boolean: true if `path` is or is in a git repositry, else false
---@return string: an error message if `path` is not a valid git repository, else an empty string
M.is_repo = function(path)
  path = path or vim.uv.cwd()

  if not require("bw.util.guard").is_string(path) then
    local error_msg = string.format("is_repo(path): path must be a string but was: %s", type(path))
    return false, error_msg
  end

  if not require("bw.util.fs").is_directory(path) then
    local error_msg = string.format("is_repo(path): %s is not a directory.", path)
    return false, error_msg
  end

  local command = string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand(path))
  vim.fn.system(command)

  if vim.v.shell_error == 0 then
    return true, ""
  else
    return false, string.format("%s is not a git repository.", path)
  end
end

--- Checks to see if a git repository contains changes
---@param path string: directory path
---@return boolean true if path is or is in a git repository and the repository contains changes, else false
M.has_changes = function(path)
  path = path or vim.uv.cwd()
  local cmd = string.format("git -C %s diff --quiet --exit-code", path)
  return M.is_repo(path) and os.execute(cmd) ~= 0
end

--- Returns the current branch name or nil and an error message.
---@param path string
---@return string|nil
---@return string
M.get_current_branch = function(path)
  path = path or vim.uv.cwd()
  local is_repo, error_msg = M.is_repo(path)
  if not is_repo then
    return nil, error_msg
  end

  local branch = vim.fn.trim(vim.fn.system("git -C " .. path .. " rev-parse --abbrev-ref HEAD"))

  if vim.v.shell_error ~= 0 then
    return nil, "An error occured."
  end

  return branch, ""
end

local needs_no_repo_warning = function(path)
  path = path or vim.uv.cwd()
  local in_repo, error_msg = M.is_repo(path)
  if not in_repo then
    warn(error_msg)
    return true
  end
  return false
end

local needs_no_changes_warning = function(path)
  path = path or vim.uv.cwd()
  if M.has_changes(path) then
    return false
  end
  warn("No Changes")
  return true
end

--- Fuzzy search for files tracked by Git. This command lists the output of the `git ls-files` command,
---@param path string: the path of the git repository (default: `cwd`)
function M.files(path)
  path = path or vim.uv.cwd()
  if not needs_no_repo_warning(path) then
    local themes = require("telescope.themes")
    local opts = themes.get_dropdown({
      cwd = path,
      winblend = 10,
      border = true,
      previewer = false,
      shorten_path = false,
      layout_config = {
        width = 0.5,
      },
    })
    require("telescope.builtin").git_files(opts)
  end
end

--- Fuzzy search (with previewer) for files tracked by Git. This command lists the output of the `git ls-files` command
---@param path string|nil: the path of the git repository (default: `cwd`)
function M.files_with_preview(path)
  path = path or vim.uv.cwd()
  if not needs_no_repo_warning(path) then
    require("telescope.builtin").git_files({ cwd = path })
  end
end

--- Fuzzy find for commits with diff preview
---@param path string|nil: the path to the git repository (default `cwd`)
function M.commits(path)
  path = path or vim.uv.cwd()
  if not needs_no_repo_warning(path) then
    require("telescope.builtin").git_commits({ cwd = path })
  end
end

--- Fuzzy find commits for the file specified by `path` (default: current buffer)
---@param path string|nil: the path to the file to view commits for (default: current buffer)
function M.buffer_commits(path)
  path = path or vim.api.nvim_buf_get_name(0)
  if not needs_no_repo_warning(path) then
    require("telescope.builtin").git_bcommits({ cwd = path })
  end
end

-- TODO: implement bcommit_range

--- List branches for a git repository, with output from `git log --oneline` shown in the preview window
---@param path string|nil: the path to the git repository (default: `cwd`)
function M.branches(path)
  path = path or vim.uv.cwd()
  if not needs_no_repo_warning(path) then
    require("telescope.builtin").git_branches({ cwd = path })
  end
end

--- Fuzzy find uncommited changes in a git repository
---@param path string|nil: the path to the git repository (default: `cwd`)
function M.status(path)
  path = path or vim.uv.cwd()
  if needs_no_repo_warning(path) or needs_no_changes_warning(path) then
    return
  end
  require("telescope.builtin").git_status({ cwd = path })
end

--- Fuzzy find stash items in a git repositoryy
---@param path string|nil: the path to the git repository (default: `cwd`)
function M.stash(path)
  path = path or vim.uv.cwd()
  if not needs_no_repo_warning(path) then
    require("telescope.builtin").git_stash({ cwd = path })
  end
end

--- Perform a ':Gdiffsplit!'
---@param path string|nil: the path to a file with git confluicts (default: current buffer)
function M.resolve_conflicts(path)
  path = path or vim.api.nvim_buf_get_name(0)
  if not needs_no_repo_warning(path) then
    vim.cmd("Gvdiffsplit!")
  end
end

--- Open a figitive (`:Git status`) split
---@param path string|nil: the path to a git repository (default: `cwd`)
function M.fugitive(path)
  path = path or vim.uv.cwd()
  if not needs_no_repo_warning(path) then
    vim.cmd("Git")
  end
end

--- Show the output of `:Git log`
---@param path string|nil: the path to a git repository (default: `cwd`)
function M.log(path)
  path = path or vim.uv.cwd()
  if not needs_no_repo_warning(path) then
    vim.cmd("Git log")
  end
end

--- Perform a `:diffget //2`
---@param path string|nil: the path to a git repository (default: `cwd`)
function M.diff_get_2(path)
  path = path or vim.uv.cwd()
  if not needs_no_repo_warning(path) then
    vim.cmd("diffget //2")
  end
end

--- Perform a `:diffget //3`
---@param path string|nil: the path to a git repository (default: `cwd`)
function M.diff_get_3(path)
  path = path or vim.uv.cwd()
  if not needs_no_repo_warning(path) then
    vim.cmd("diffget //3")
  end
end

return M
