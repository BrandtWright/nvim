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
