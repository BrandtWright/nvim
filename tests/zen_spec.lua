-- bw.util.zen.toggle: the one piece of real stateful logic extracted out of
-- config/keymaps.lua. The invariant that matters is the laststatus round-trip --
-- enabling blanks it and stashes the prior value, disabling restores exactly
-- that value. The tmux side effects are gated on $TMUX, so with $TMUX unset the
-- behaviour is fully testable without a tmux server; we stub os.getenv to force
-- that and os.execute to prove the gate holds (no spurious tmux shell-outs).

local zen = require("bw.util.zen")

describe("bw.util.zen.toggle", function()
  local orig_getenv = os.getenv
  local orig_execute = os.execute
  local orig_laststatus, orig_zen, orig_saved
  local execute_calls

  before_each(function()
    -- Snapshot global state we mutate so it doesn't leak across the shared
    -- headless instance.
    orig_laststatus = vim.o.laststatus
    orig_zen = vim.g.zen_mode
    orig_saved = vim.g.zen_mode_last_status

    -- Pretend we are NOT inside tmux so the tmux branches are skipped.
    ---@diagnostic disable-next-line: duplicate-set-field
    os.getenv = function(name)
      if name == "TMUX" then
        return nil
      end
      return orig_getenv(name)
    end

    -- Record any shell-outs so we can assert none happen outside tmux.
    execute_calls = {}
    ---@diagnostic disable-next-line: duplicate-set-field
    os.execute = function(cmd)
      execute_calls[#execute_calls + 1] = cmd
      return 0
    end

    vim.g.zen_mode = nil
  end)

  after_each(function()
    os.getenv = orig_getenv
    os.execute = orig_execute
    vim.o.laststatus = orig_laststatus
    vim.g.zen_mode = orig_zen
    vim.g.zen_mode_last_status = orig_saved
  end)

  it("enabling blanks laststatus and stashes the prior value", function()
    vim.o.laststatus = 3
    zen.toggle()
    assert.equals(0, vim.o.laststatus)
    assert.is_true(vim.g.zen_mode)
    assert.equals(3, vim.g.zen_mode_last_status)
  end)

  it("toggling twice restores the original laststatus and clears the flag", function()
    vim.o.laststatus = 3
    zen.toggle() -- on
    zen.toggle() -- off
    assert.equals(3, vim.o.laststatus)
    assert.is_false(vim.g.zen_mode)
  end)

  it("restores whatever laststatus was active, not a hardcoded default", function()
    vim.o.laststatus = 2 -- a non-default value
    zen.toggle() -- on
    zen.toggle() -- off
    assert.equals(2, vim.o.laststatus)
  end)

  it("does not shell out to tmux when $TMUX is unset", function()
    vim.o.laststatus = 3
    zen.toggle() -- on
    zen.toggle() -- off
    assert.same({}, execute_calls)
  end)
end)

-- Regression: inside tmux, a failed/empty `tmux show -gv status` must not yield
-- an argument-less `tmux set -g status` on restore (which tmux rejects). Both
-- the save and restore paths fall back to "on".
describe("bw.util.zen.toggle inside tmux", function()
  local orig_getenv = os.getenv
  local orig_execute = os.execute
  local orig_system = vim.fn.system
  local orig_laststatus, orig_zen, orig_saved, orig_bar
  local execute_calls
  local system_output

  before_each(function()
    orig_laststatus = vim.o.laststatus
    orig_zen = vim.g.zen_mode
    orig_saved = vim.g.zen_mode_last_status
    orig_bar = vim.g.zen_mode_tmux_status_bar

    ---@diagnostic disable-next-line: duplicate-set-field
    os.getenv = function(name)
      if name == "TMUX" then
        return "/tmp/tmux-1000/default,1234,0"
      end
      return orig_getenv(name)
    end

    execute_calls = {}
    ---@diagnostic disable-next-line: duplicate-set-field
    os.execute = function(cmd)
      execute_calls[#execute_calls + 1] = cmd
      return 0
    end

    -- Stub the status query; `system_output` is set per-test.
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.fn.system = function()
      return system_output
    end

    vim.g.zen_mode = nil
  end)

  after_each(function()
    os.getenv = orig_getenv
    os.execute = orig_execute
    vim.fn.system = orig_system
    vim.o.laststatus = orig_laststatus
    vim.g.zen_mode = orig_zen
    vim.g.zen_mode_last_status = orig_saved
    vim.g.zen_mode_tmux_status_bar = orig_bar
  end)

  it("stashes the real status and restores it", function()
    system_output = "on\n"
    zen.toggle() -- on: saves status, turns it off
    assert.equals("on", vim.g.zen_mode_tmux_status_bar)
    assert.equals("tmux set -g status off", execute_calls[1])
    zen.toggle() -- off: restores
    assert.equals("tmux set -g status on", execute_calls[2])
  end)

  it("falls back to 'on' when the status query returns empty", function()
    system_output = ""
    zen.toggle() -- on
    assert.equals("on", vim.g.zen_mode_tmux_status_bar)
    zen.toggle() -- off
    -- The bug: this used to be "tmux set -g status " (no argument).
    assert.equals("tmux set -g status on", execute_calls[2])
  end)

  it("falls back to 'on' when restoring a missing stashed value", function()
    -- Simulate zen mode already on but with no/empty saved tmux status.
    vim.g.zen_mode = true
    vim.g.zen_mode_last_status = 3
    vim.g.zen_mode_tmux_status_bar = ""
    zen.toggle() -- restore
    assert.equals("tmux set -g status on", execute_calls[1])
  end)
end)
