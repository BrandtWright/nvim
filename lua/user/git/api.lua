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

return M
