--------------------------------------------------------------------------------
-- Adds slightly better validation and error handling on top of snacks pickers,
-- fugitive, and gitsigns and provides some utility functions
--------------------------------------------------------------------------------

---@class GitOpts
---@field cwd? string Current working directory (defaults to vim.uv.cwd())
---@field [string] any Additional snacks/git options

local Either = require("bw.types.either")

local icon = ""
local module_name = "plugins.git.api"

---@param msg string Error message to display
local warn = function(msg)
  local toaster = require("bw.util.notification")
  toaster.warn(msg, icon, module_name)
end

---@param opts GitOpts
---@return Either
local validate_git_directory = function(opts)
  -- Not a string
  if type(opts.cwd) ~= "string" then
    return Either.left(string.format("expected type: `string` but got type: `%s`", type(opts.cwd)))
  end

  -- Not a directory
  local stat = vim.uv.fs_stat(opts.cwd)
  if not stat or stat.type ~= "directory" then
    return Either.left(string.format("%s is not a directory", opts.cwd))
  end

  -- Not a git directory. Use the argv (list) form so paths with spaces or
  -- shell metacharacters are passed to git verbatim, with no shell involved.
  local result = vim.system({ "git", "-C", opts.cwd, "rev-parse", "--show-toplevel" }):wait()
  if result.code ~= 0 then
    return Either.left(string.format("%s is not a git directory", opts.cwd))
  end

  return Either.right(opts)
end

---@param opts? GitOpts
---@return Either
local apply_default_values = function(opts)
  opts = opts or {}
  -- vim.uv.cwd() is typed string|nil; vim.fn.getcwd() never returns nil, so the
  -- chain resolves to a string for vim.fs.normalize (which requires one).
  opts.cwd = vim.fs.normalize(opts.cwd or vim.uv.cwd() or vim.fn.getcwd())
  return Either.right(opts)
end

---@param opts GitOpts
---@return Either
local function has_git_changes(opts)
  local result = vim.system({ "git", "-C", opts.cwd, "status", "--porcelain" }):wait()
  -- If there's any output, then there are uncommitted changes
  if result.code == 0 and (result.stdout or "") ~= "" then
    return Either.right(opts)
  end
  return Either.left(string.format("No uncommitted changes in %s", opts.cwd))
end

local M = {}

--------------------------------------------------------------------------------
-- Methods
--------------------------------------------------------------------------------

--- Fuzzy search for files tracked by Git. This command lists the output of the
--- `git ls-files` command
---@param opts? GitOpts Options for git files search
function M.files(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    Snacks.picker.git_files(result.value)
  else
    result:handle_error(warn)
  end
end

--- Fuzzy find for commits with diff preview
---@param opts? GitOpts Options for git commits search
function M.commits(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    Snacks.picker.git_log(result.value)
  else
    result:handle_error(warn)
  end
end

--- List branches for a git repository, with output from `git log --oneline` shown in the preview window
---@param opts? GitOpts Options for git branches search
function M.branches(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    Snacks.picker.git_branches(result.value)
  else
    result:handle_error(warn)
  end
end

--- Fuzzy find uncommited changes in a git repository
---@param opts? GitOpts Options for git status search
function M.status(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory):bind(has_git_changes)
  if result.is_right then
    Snacks.picker.git_status(result.value)
  else
    result:handle_error(warn)
  end
end

--- Fuzzy find stash items in a git repository
---@param opts? GitOpts Options for git stash search
function M.stash(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    Snacks.picker.git_stash(result.value)
  else
    result:handle_error(warn)
  end
end

--- Perform a ':Gvdiffsplit!'
---@param opts? GitOpts Options for resolving conflicts
function M.resolve_conflicts(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    vim.cmd("Gvdiffsplit!")
  else
    result:handle_error(warn)
  end
end

--- Open a fugitive (`:Git status`) split
---@param opts? GitOpts Options for fugitive
function M.fugitive(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    vim.cmd("Git")
  else
    result:handle_error(warn)
  end
end

--- Show the output of `:Git log`
---@param opts? GitOpts Options for git log
function M.log(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    vim.cmd("Git log")
  else
    result:handle_error(warn)
  end
end

--- Perform a `:diffget //2`
---@param opts? GitOpts Options for diff get
function M.diff_get_2(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    vim.cmd("diffget //2")
  else
    result:handle_error(warn)
  end
end

--- Perform a `:diffget //3`
---@param opts? GitOpts Options for diff get
function M.diff_get_3(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    vim.cmd("diffget //3")
  else
    result:handle_error(warn)
  end
end

--- Fuzzy find commits for the file specified by `path` (default: current buffer)
---@param opts? GitOpts Options for buffer commits search
function M.buffer_commits(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    Snacks.picker.git_log_file(result.value)
  else
    result:handle_error(warn)
  end
end

---@param opts? GitOpts Options for buffer commits search
function M.line_commits(opts)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  if result.is_right then
    Snacks.picker.git_log_line(result.value)
  else
    result:handle_error(warn)
  end
end

return M
