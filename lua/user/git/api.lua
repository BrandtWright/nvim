--------------------------------------------------------------------------------
-- Adds slightly better validation and error hendling on top of telescope.nvim,
-- fugitive, and gitsigns and provides somee utility functions
--------------------------------------------------------------------------------

local Either = require("user.types.either")

local icon = ""
local module_name = "user.git.api"

local warn = function(msg)
  local toaster = require("user.notification.api")
  toaster.warn(msg, icon, module_name)
end

local validate_git_directory = function(opts)
  -- Not a string
  if type(opts.cwd) ~= "string" then
    return Either.left(string.format("expected type: `string` but got type: `%s`", type(opts.cwd)))
  end

  -- Not a directory
  local stat = vim.loop.fs_stat(opts.cwd)
  if not stat or stat.type ~= "directory" then
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
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory):bind(apply_drop_down_theme)
  if result.is_right then
    require("telescope.builtin").git_files(result.value)
  else
    result:handle_error(warn)
  end
end

--- Fuzzy search (with previewer) for files tracked by Git. This command lists
--- the output of the `git ls-files` command
function M.files_with_preview(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    require("telescope.builtin").git_files(result.value)
  else
    result:handle_error(warn)
  end
end

--- Fuzzy find for commits with diff preview
function M.commits(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    require("telescope.builtin").git_commits(result.value)
  else
    result:handle_error(warn)
  end
end

--- List branches for a git repository, with output from `git log --oneline` shown in the preview window
function M.branches(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    require("telescope.builtin").git_branches(result.value)
  else
    result:handle_error(warn)
  end
end

--- Fuzzy find uncommited changes in a git repository
function M.status(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    require("telescope.builtin").git_status(result.value)
  else
    result:handle_error(warn)
  end
end

--- Fuzzy find stash items in a git repositoryy
function M.stash(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    require("telescope.builtin").git_stash(result.value)
  else
    result:handle_error(warn)
  end
end

--- Perform a ':Gdiffsplit!'
function M.resolve_conflicts(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    vim.cmd("Gvdiffsplit!")
  else
    result:handle_error(warn)
  end
end

--- Open a figitive (`:Git status`) split
function M.fugitive(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    vim.cmd("Git")
  else
    result:handle_error(warn)
  end
end

--- Show the output of `:Git log`
function M.log(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    vim.cmd("Git log")
  else
    result:handle_error(warn)
  end
end

--- Perform a `:diffget //2`
function M.diff_get_2(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    vim.cmd("diffget //2")
  else
    result:handle_error(warn)
  end
end

--- Perform a `:diffget //3`
function M.diff_get_3(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    vim.cmd("diffget //3")
  else
    result:handle_error(warn)
  end
end

--- Fuzzy find commits for the file specified by `path` (default: current buffer)
function M.buffer_commits(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    require("telescope.builtin").git_bcommits({ current_file = opts })
  else
    result:handle_error(warn)
  end
end

--- Fuzzy find commits for the file specified by `path` (default: current buffer)
function M.buffer_commits_range(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    require("telescope.builtin").git_bcommits_range(opts)
  else
    result:handle_error(warn)
  end
end

return M
