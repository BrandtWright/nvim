--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------
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

local validate_git_directory = function(opts)
  -- Not a string
  if type(opts.cwd) ~= "string" then
    return Either.left(string.format("expected type: `string` but got type: `%s`", type(opts.cwd)))
  end

  -- Not a directory
  local lfs = require("lfs")
  local attr = lfs.attributes(opts.cwd)
  if not attr or attr.mode ~= "directory" then
    return Either.left(string.format("%s is not a directory", opts.cwd))
  end

  -- Not a git directory
  local path = vim.fn.expand(opts.cwd)
  local cmd = string.format("git -C %s rev-parse --show-toplevel", path)
  vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    return Either.left(string.format("%s is not a git directory", opts.cwd))
  end

  return Either.right(opts)
end

local apply_default_values = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  return Either.right(opts)
end

---@param opts table
---@return Either
local apply_drop_down_theme = function(opts)
  local themes = require("telescope.themes")
  local defaults = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
    layout_config = {
      width = 0.5,
    },
  })
  opts = vim.tbl_deep_extend("force", opts, defaults)
  return Either.right(opts)
end

local M = {}

--------------------------------------------------------------------------------
-- Methods
--------------------------------------------------------------------------------

--- Fuzzy search for files tracked by Git. This command lists the output of the
--- `git ls-files` command
function M.files(opts)
  local result = Either.unit(opts)
    :bind(apply_default_values)
    :bind(validate_git_directory)
    :bind(apply_drop_down_theme)
  if result.is_right then
    require("telescope.builtin").git_files(result.value)
  else
    result:handle_error(warn)
  end
end

--- Fuzzy search (with previewer) for files tracked by Git. This command lists
--- the output of the `git ls-files` command
function M.files_with_preview(opts)
  local result = Either.unit(opts)
    :bind(apply_default_values)
    :bind(validate_git_directory)
  if result.is_right then
    require("telescope.builtin").git_files(result.value)
  else
    result:handle_error(warn)
  end
end

--- Fuzzy find for commits with diff preview
function M.commits(opts)
  local result = Either.unit(opts)
    :bind(apply_default_values)
    :bind(validate_git_directory)
  if result.is_right then
    require("telescope.builtin").git_commits(result.value)
  else
    result:handle_error(warn)
  end
end

--- List branches for a git repository, with output from `git log --oneline` shown in the preview window
function M.branches(opts)
  local result = Either.unit(opts)
    :bind(apply_default_values)
    :bind(validate_git_directory)
  if result.is_right then
    require("telescope.builtin").git_branches(result.value)
  else
    result:handle_error(warn)
  end
end

--- Fuzzy find uncommited changes in a git repository
function M.status(opts)
  local result = Either.unit(opts)
    :bind(apply_default_values)
    :bind(validate_git_directory)
  if result.is_right then
    require("telescope.builtin").git_status(result.value)
  else
    result:handle_error(warn)
  end
end

--- Fuzzy find stash items in a git repositoryy
function M.stash(opts)
  local result = Either.unit(opts)
    :bind(apply_default_values)
    :bind(validate_git_directory)
  if result.is_right then
    require("telescope.builtin").git_stash(result.value)
  else
    result:handle_error(warn)
  end
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
function M.fugitive(opts)
  local result = Either.unit(opts)
    :bind(apply_default_values)
    :bind(validate_git_directory)
  if result.is_right then
    vim.cmd("Git")
  else
    result:handle_error(warn)
  end
end

--- Show the output of `:Git log`
function M.log(opts)
  local result = Either.unit(opts)
    :bind(apply_default_values)
    :bind(validate_git_directory)
  if result.is_right then
    vim.cmd("Git log")
  else
    result:handle_error(warn)
  end
end

--- Perform a `:diffget //2`
function M.diff_get_2(opts)
  local result = Either.unit(opts)
    :bind(apply_default_values)
    :bind(validate_git_directory)
  if result.is_right then
    vim.cmd("diffget //2")
  else
    result:handle_error(warn)
  end
end

--- Perform a `:diffget //3`
function M.diff_get_3(opts)
  local result = Either.unit(opts)
    :bind(apply_default_values)
    :bind(validate_git_directory)
  if result.is_right then
    vim.cmd("diffget //3")
  else
    result:handle_error(warn)
  end
end

-- FIX: instrument bcommits and bcommit_range with friendlier validation

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
