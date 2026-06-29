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

-- Bound on the synchronous git probes below. Local git answers in a few ms, so
-- the timeout only bites when the working tree is on a hung/network filesystem
-- or git stalls (e.g. on a credential prompt): a wedged git then fails fast with
-- a warning instead of freezing the UI indefinitely on the :wait().
local GIT_PROBE_TIMEOUT_MS = 2000

---@param msg string Error message to display
local warn = function(msg)
  local toaster = require("bw.util.notification")
  toaster.warn(msg, module_name, icon)
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
  local result = vim.system({ "git", "-C", opts.cwd, "rev-parse", "--show-toplevel" }):wait(GIT_PROBE_TIMEOUT_MS)
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

--- Directory of the current buffer, or nil for an unnamed buffer (so the
--- pipeline's apply_default_values falls back to Neovim's cwd).
---@return string|nil
local function current_buffer_dir()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    return nil
  end
  return vim.fn.fnamemodify(name, ":p:h")
end

--- Seeds opts.cwd from the current buffer's directory when the caller didn't
--- specify one. The fugitive (`:Git`) and `:diffget`/`:Gvdiffsplit!` actions
--- below act on the *current buffer's* repository, not on opts.cwd, so they must
--- validate against the buffer's directory -- otherwise validation could pass
--- for Neovim's global cwd while fugitive operates on a different repo.
---@param opts? GitOpts
---@return GitOpts
local function with_buffer_cwd(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or current_buffer_dir()
  return opts
end

---@param opts GitOpts
---@return Either
local function has_git_changes(opts)
  local result = vim.system({ "git", "-C", opts.cwd, "status", "--porcelain" }):wait(GIT_PROBE_TIMEOUT_MS)
  -- If there's any output, then there are uncommitted changes
  if result.code == 0 and (result.stdout or "") ~= "" then
    return Either.right(opts)
  end
  return Either.left(string.format("No uncommitted changes in %s", opts.cwd))
end

--- Runs opts through the validation pipeline (default cwd -> real directory ->
--- git repository, plus any extra validators such as has_git_changes), then
--- dispatches to `action` with the validated opts on success, or routes the
--- failure message to a warning toast. This collapses the validate-then-dispatch
--- boilerplate that every method below would otherwise repeat verbatim.
---@param opts? GitOpts
---@param action fun(opts: GitOpts) Called with the validated opts when all checks pass
---@param ... fun(opts: GitOpts): Either Extra validators bound after the git-directory check
local function with_validated_git(opts, action, ...)
  local result = Either.unit(opts):bind(apply_default_values):bind(validate_git_directory)
  for _, validator in ipairs({ ... }) do
    result = result:bind(validator)
  end
  if result.is_right then
    action(result.value)
  else
    result:handle_error(warn)
  end
end

local M = {}

--------------------------------------------------------------------------------
-- Methods
--------------------------------------------------------------------------------

--- Fuzzy search for files tracked by Git. This command lists the output of the
--- `git ls-files` command
---@param opts? GitOpts Options for git files search
function M.files(opts)
  with_validated_git(opts, function(o)
    Snacks.picker.git_files(o)
  end)
end

--- Fuzzy find for commits with diff preview
---@param opts? GitOpts Options for git commits search
function M.commits(opts)
  with_validated_git(opts, function(o)
    Snacks.picker.git_log(o)
  end)
end

--- List branches for a git repository, with output from `git log --oneline` shown in the preview window
---@param opts? GitOpts Options for git branches search
function M.branches(opts)
  with_validated_git(opts, function(o)
    Snacks.picker.git_branches(o)
  end)
end

--- Fuzzy find uncommited changes in a git repository
---@param opts? GitOpts Options for git status search
function M.status(opts)
  with_validated_git(opts, function(o)
    Snacks.picker.git_status(o)
  end, has_git_changes)
end

--- Fuzzy find stash items in a git repository
---@param opts? GitOpts Options for git stash search
function M.stash(opts)
  with_validated_git(opts, function(o)
    Snacks.picker.git_stash(o)
  end)
end

--- Perform a ':Gvdiffsplit!'
---@param opts? GitOpts Options for resolving conflicts
function M.resolve_conflicts(opts)
  with_validated_git(with_buffer_cwd(opts), function()
    vim.cmd("Gvdiffsplit!")
  end)
end

--- Open a fugitive (`:Git status`) split
---@param opts? GitOpts Options for fugitive
function M.fugitive(opts)
  with_validated_git(with_buffer_cwd(opts), function()
    vim.cmd("Git")
  end)
end

--- Show the output of `:Git log`
---@param opts? GitOpts Options for git log
function M.log(opts)
  with_validated_git(with_buffer_cwd(opts), function()
    vim.cmd("Git log")
  end)
end

--- Perform a `:diffget //2`
---@param opts? GitOpts Options for diff get
function M.diff_get_2(opts)
  with_validated_git(with_buffer_cwd(opts), function()
    vim.cmd("diffget //2")
  end)
end

--- Perform a `:diffget //3`
---@param opts? GitOpts Options for diff get
function M.diff_get_3(opts)
  with_validated_git(with_buffer_cwd(opts), function()
    vim.cmd("diffget //3")
  end)
end

--- Fuzzy find commits for the file specified by `path` (default: current buffer)
---@param opts? GitOpts Options for buffer commits search
function M.buffer_commits(opts)
  with_validated_git(opts, function(o)
    Snacks.picker.git_log_file(o)
  end)
end

---@param opts? GitOpts Options for buffer commits search
function M.line_commits(opts)
  with_validated_git(opts, function(o)
    Snacks.picker.git_log_line(o)
  end)
end

return M
