-- Exercises the "Grammar Checker" toggle builder in lua/bw/util/grammar.lua.
-- The builder is pure (no Snacks/keymap side effects), so we build the toggle
-- config and drive its get/set against a stubbed vim.lsp -- no real LSP needed.

local grammar = require("bw.util.grammar")

describe("grammar checker toggle", function()
  local toggle
  local orig
  local enable_calls
  local filetype_fired
  local clients

  before_each(function()
    toggle = grammar.checker_toggle()
    enable_calls = {}
    filetype_fired = 0
    clients = {} -- no harper_ls clients attached by default

    orig = {
      get_clients = vim.lsp.get_clients,
      enable = vim.lsp.enable,
      exec_autocmds = vim.api.nvim_exec_autocmds,
    }

    vim.lsp.get_clients = function()
      return clients
    end
    vim.lsp.enable = function(name, enabled)
      table.insert(enable_calls, { name = name, enabled = enabled })
    end
    vim.api.nvim_exec_autocmds = function(event)
      if event == "FileType" then
        filetype_fired = filetype_fired + 1
      end
    end
  end)

  after_each(function()
    vim.lsp.get_clients = orig.get_clients
    vim.lsp.enable = orig.enable
    vim.api.nvim_exec_autocmds = orig.exec_autocmds
  end)

  it("get() reports a boolean reflecting harper_ls client presence", function()
    assert.equals("boolean", type(toggle.get()))
    assert.is_false(toggle.get())

    clients = { { name = "harper_ls" } }
    assert.is_true(toggle.get())
  end)

  it("set(true) enables harper_ls and re-fires FileType to attach", function()
    toggle.set(true)
    assert.equals("harper_ls", enable_calls[1].name)
    assert.is_nil(enable_calls[1].enabled) -- enable, not disable
    assert.equals(1, filetype_fired)
  end)

  it("set(false) stops running clients and disables harper_ls", function()
    local stopped = 0
    clients = { {
      name = "harper_ls",
      stop = function()
        stopped = stopped + 1
      end,
    } }
    toggle.set(false)
    assert.equals(1, stopped)
    local last = enable_calls[#enable_calls]
    assert.equals("harper_ls", last.name)
    assert.is_false(last.enabled)
  end)
end)
