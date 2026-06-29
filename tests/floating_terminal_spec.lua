-- floating-terminal.lua must not freeze cwd at spec-import time. The terminal
-- should open in the cwd that is current when the toggle keymap fires.

local function get_opts(spec)
  return type(spec.opts) == "function" and spec.opts(nil, {}) or spec.opts
end

describe("floating terminal", function()
  local spec = require("plugins.floating-terminal")[1]

  -- The cwd test stubs the global _G.Snacks; snapshot and restore it so the stub
  -- doesn't leak into other specs sharing this headless instance.
  local orig_snacks
  before_each(function()
    orig_snacks = _G.Snacks
  end)
  after_each(function()
    _G.Snacks = orig_snacks
  end)

  it("does not bake a frozen cwd into the terminal opts", function()
    local opts = get_opts(spec)
    assert.is_nil(opts.terminal.cwd)
  end)

  it("passes the current cwd when the toggle keymap fires", function()
    local captured
    ---@diagnostic disable-next-line: missing-fields -- intentional partial stub of Snacks
    _G.Snacks = {
      terminal = {
        toggle = function(cmd, o)
          captured = { cmd = cmd, opts = o }
        end,
      },
    }
    local rhs = spec.keys[1][2]
    rhs()
    assert.equals("bash", captured.cmd)
    assert.equals(vim.fn.getcwd(), captured.opts.cwd)
  end)
end)
