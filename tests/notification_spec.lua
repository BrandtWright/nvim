-- bw.util.notification builds level-bound toasters over vim.notify. Stub
-- vim.notify to capture what each toaster forwards (level + title/icon), and
-- restore it after each test so the stub doesn't leak into other specs.

local toast = require("bw.util.notification")

describe("bw.util.notification", function()
  local captured
  local orig_notify

  before_each(function()
    captured = nil
    orig_notify = vim.notify
    vim.notify = function(msg, level, opts)
      captured = { msg = msg, level = level, opts = opts or {} }
    end
  end)

  after_each(function()
    vim.notify = orig_notify
  end)

  it("info() forwards the INFO level with title and icon", function()
    toast.info("hello", "Title", "")
    assert.equals("hello", captured.msg)
    assert.equals(vim.log.levels.INFO, captured.level)
    assert.equals("Title", captured.opts.title)
    assert.equals("", captured.opts.icon)
  end)

  it("warn() forwards the WARN level", function()
    toast.warn("careful", "Source")
    assert.equals(vim.log.levels.WARN, captured.level)
    assert.equals("Source", captured.opts.title)
    assert.is_nil(captured.opts.icon)
  end)

  it("error() forwards the ERROR level and tolerates a missing title", function()
    toast.error("boom")
    assert.equals(vim.log.levels.ERROR, captured.level)
    assert.is_nil(captured.opts.title)
  end)
end)
