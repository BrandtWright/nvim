--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------
local fs = require("bw.util.fs")
local Either = require("user.types.either")

--------------------------------------------------------------------------------
-- Locals
--------------------------------------------------------------------------------

local icon = ""
local module_name = "user.git.api"

local warn = function(msg)
  local toaster = require("user.notification.api")
  toaster.warn(msg, icon, module_name)
end

local string_or_error = function(x)
  return type(x) == "string" and Either.right(x)
    or Either.left(string.format("expected type: `string` but got type: `%s`", type(x)))
end

local number_or_error = function(x)
  return type(x) == "number" and Either.right(x)
    or Either.left(string.format("expected type: `number` but got type: `%s`", type(x)))
end

local directory_or_error = function(x)
  return string_or_error(x):bind(function(y)
    local lfs = require("lfs")
    local attr = lfs.attributes(y)
    return attr and attr.mode == "directory" and Either.right(y)
      or Either.left(string.format("%s is not a directory", y))
  end)
end

local git_directory_or_error = function(x)
  return directory_or_error(x):bind(function(y)
    local path = vim.fn.expand(y)
    local cmd = string.format("git -C %s rev-parse --show-toplevel", path)
    vim.fn.systemlist(cmd)
    return vim.v.shell_error == 0 and Either.right(y) or Either.left(string.format("%s is not a git directory", y))
  end)
end

local M = {}

--------------------------------------------------------------------------------
-- Methods
--------------------------------------------------------------------------------

--- Fuzzy search for files tracked by Git. This command lists the output of the `git ls-files` command
---@param path string: the path of the git repository (default: `cwd`)
function M.files(path)
  path = path or vim.uv.cwd()
  local result = git_directory_or_error(path)
  if not result.is_right then
    result:handle_error(warn)
    return
  end

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

--- Fuzzy search (with previewer) for files tracked by Git. This command lists the output of the `git ls-files` command
---@param path string|nil: the path of the git repository (default: `cwd`)
function M.files_with_preview(path)
  path = path or vim.uv.cwd()
  local result = git_directory_or_error(path)
  if not result.is_right then
    result:handle_error(warn)
    return
  end
  require("telescope.builtin").git_files({ cwd = path })
end

--- Fuzzy find for commits with diff preview
---@param path string|nil: the path to the git repository (default `cwd`)
function M.commits(path)
  path = path or vim.uv.cwd()
  local result = git_directory_or_error(path)
  if not result.is_right then
    result:handle_error(warn)
    return
  end
  require("telescope.builtin").git_commits({ cwd = path })
end

--- List branches for a git repository, with output from `git log --oneline` shown in the preview window
---@param path string|nil: the path to the git repository (default: `cwd`)
function M.branches(path)
  path = path or vim.uv.cwd()
  local result = git_directory_or_error(path)
  if not result.is_right then
    result:handle_error(warn)
    return
  end
  require("telescope.builtin").git_branches({ cwd = path })
end

--- Fuzzy find uncommited changes in a git repository
---@param path string|nil: the path to the git repository (default: `cwd`)
function M.status(path)
  path = path or vim.uv.cwd()
  local result = git_directory_or_error(path)
  if not result.is_right then
    result:handle_error(warn)
    return
  end
  require("telescope.builtin").git_status({ cwd = path })
end

--- Fuzzy find stash items in a git repositoryy
---@param path string|nil: the path to the git repository (default: `cwd`)
function M.stash(path)
  path = path or vim.uv.cwd()
  local result = git_directory_or_error(path)
  if not result.is_right then
    result:handle_error(warn)
    return
  end
  require("telescope.builtin").git_stash({ cwd = path })
end

--- Perform a ':Gdiffsplit!'
---@param path string|nil: the path to a file with git confluicts (default: current buffer)
function M.resolve_conflicts(path)
  path = path or vim.api.nvim_buf_get_name(0)
  local result = git_directory_or_error(path)
  if not result.is_right then
    result:handle_error(warn)
    return
  end
  vim.cmd("Gvdiffsplit!")
end

--- Open a figitive (`:Git status`) split
---@param path string|nil: the path to a git repository (default: `cwd`)
function M.fugitive(path)
  path = path or vim.uv.cwd()
  local result = git_directory_or_error(path)
  if not result.is_right then
    result:handle_error(warn)
    return
  end
  vim.cmd("Git")
end

--- Show the output of `:Git log`
---@param path string|nil: the path to a git repository (default: `cwd`)
function M.log(path)
  path = path or vim.uv.cwd()
  local result = git_directory_or_error(path)
  if not result.is_right then
    result:handle_error(warn)
    return
  end
  vim.cmd("Git log")
end

--- Perform a `:diffget //2`
---@param path string|nil: the path to a git repository (default: `cwd`)
function M.diff_get_2(path)
  path = path or vim.uv.cwd()
  local result = git_directory_or_error(path)
  if not result.is_right then
    result:handle_error(warn)
    return
  end
  vim.cmd("diffget //2")
end

--- Perform a `:diffget //3`
---@param path string|nil: the path to a git repository (default: `cwd`)
function M.diff_get_3(path)
  path = path or vim.uv.cwd()
  local result = git_directory_or_error(path)
  if not result.is_right then
    result:handle_error(warn)
    return
  end
  vim.cmd("diffget //3")
end

--- Fuzzy find commits for the file specified by `path` (default: current buffer)
---@param path string|nil: the path to the file to view commits for (default: current buffer)
function M.buffer_commits(path)
  path = path or vim.api.nvim_buf_get_name(0)
  local result = git_directory_or_error(path)
  if not result.is_right then
    result:handle_error(warn)
    return
  end
  require("telescope.builtin").git_bcommits({ cwd = path })
end

--- Fuzzy find commits for the file specified by `path` (default: current buffer)
---@param path string|nil: the path to the file to view commits for (default: current buffer)
---@param from number: the line number of the start range to find commits for
---@param to number: the line number of the end range to find commits for
function M.buffer_commits_range(path, from, to)
  path = path or vim.api.nvim_buf_get_name(0)
  local result = git_directory_or_error(path)
  if not result.is_right then
    result:handle_error(warn)
    return
  end
  require("telescope.builtin").git_bcommits_range({ current_file = path, from = from, to = to })
end
--------------------------------------------------------------------------------
-- Clean Up
--------------------------------------------------------------------------------

local is_string = require("bw.util.guard").is_string
local is_file = require("bw.util.fs").is_file
local is_directory = require("bw.util.fs").is_directory
local base_path = require("bw.util.fs").base_path

local is_file_or_directory = function(path)
  return is_file(path) or is_directory(path)
end

local find_rev_parse_location = function(path)
  if is_directory(path) then
    return path
  elseif is_file(path) then
    return base_path(path)
  else
    return nil
  end
end

M.is_git_root = function(path)
  if not is_directory(path) then
    return false
  end
  local file_path = vim.fn.expand(path)
  local cmd = string.format("git -C %s rev-parse --show-toplevel", file_path)
  local result = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    return false
  end
  return result[1]:gsub("/$", "") == file_path:gsub("/$", "")
end

M.get_root = function(path)
  local rev_pase_location = find_rev_parse_location(path)
  local cmd = string.format("git -C %s rev-parse --show-toplevel", rev_pase_location)
  local result = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    return nil
  end
  return result[1]
end

M.is_tracked = function(path)
  if not is_file(path) and not is_directory(path) then
    vim.notify("Didn't Run")
    return false
  end
  local rev_pase_location = find_rev_parse_location(path)
  local cmd = string.format("git -C %s ls-files --error-unmatch %s", rev_pase_location, path)
  local _ = vim.fn.systemlist(cmd)
  return vim.v.shell_error == 0
end

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
---@param path string: path to a directory or file
---@return boolean true if path is or is in a git repository and the repository contains changes, else false
M.repo_has_changes = function(path)
  path = path or vim.uv.cwd()
  if not is_file_or_directory(path) then
    return false
  end
  local repo_path = M.get_root(path)
  if not repo_path then
    return false
  end
  local cmd = string.format("git -C %s diff --quiet --exit-code", repo_path)
  return os.execute(cmd) ~= 0
end

---@class GetBranchResult
---@field success boolean: successful?
---@field branch_name string|nil: name of branch
---@field error_msg string|nil: an error

--- Get the name of the current branch in a git repository
---
--- - Testing one two three
---@param path string: the path of a git repository
---@return string|nil: the name of the current branch if `path` is a git repository, else nil
---@return string: an empty string if the current branch could be resoved from `path`, else an error message
M.get_current_branch = function(path)
  path = path or vim.uv.cwd()

  if not is_file_or_directory(path) then
    local format_string = "get_current_branch(path): not a file or directory: %s"
    local error_msg = string.format(format_string, path)
    return nil, error_msg
  end

  if not M.is_git_root(path) then
    local format_string = "get_current_branch(path): Not a git repository:\n %s"
    local error_msg = string.format(format_string, path)
    return nil, error_msg
  end

  local cmd = string.format("git -C %s rev-parse --abbrev-ref HEAD", path)
  local branch = vim.fn.trim(vim.fn.system(cmd))
  if vim.v.shell_error ~= 0 then
    local format_string = "get_current_branch(path): An error occured executing `%s`"
    local error_msg = string.format(format_string, cmd)
    return nil, error_msg
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
  if M.repo_has_changes(path) then
    return false
  end
  warn("No Changes")
  return true
end

return M
