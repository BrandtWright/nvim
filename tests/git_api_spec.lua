-- plugins/git/api.lua: validated cwd must reach the snacks picker, and git
-- invocations must tolerate paths with spaces/metacharacters (argv form).
-- Snacks.picker is stubbed so we can capture what each method forwards.

local api = require("plugins.git.api")

local function make_repo(suffix)
  local dir = vim.fs.normalize(vim.fn.tempname() .. suffix)
  vim.fn.mkdir(dir, "p")
  vim.system({ "git", "-C", dir, "init" }):wait()
  return dir
end

local function stub_snacks()
  local captured = {}
  ---@diagnostic disable-next-line: missing-fields -- intentional partial stub of Snacks
  _G.Snacks = {
    picker = setmetatable({}, {
      __index = function(_, k)
        return function(o)
          captured[k] = o or {}
        end
      end,
    }),
  }
  return captured
end

describe("git.api", function()
  it("passes the validated cwd through to the snacks picker", function()
    local repo = make_repo("-gitrepo")
    local captured = stub_snacks()
    api.files({ cwd = repo })
    assert.is_truthy(captured.git_files)
    assert.equals(repo, captured.git_files.cwd)
  end)

  it("validates repos in paths containing spaces (argv form, no shell)", function()
    local repo = make_repo(" with space")
    local captured = stub_snacks()
    api.files({ cwd = repo })
    assert.is_truthy(captured.git_files)
    assert.equals(repo, captured.git_files.cwd)
  end)

  it("does not open the picker for a non-git directory", function()
    local dir = vim.fs.normalize(vim.fn.tempname() .. "-plain")
    vim.fn.mkdir(dir, "p")
    local captured = stub_snacks()
    api.files({ cwd = dir })
    assert.is_nil(captured.git_files)
  end)
end)
