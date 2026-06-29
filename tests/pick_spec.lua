-- bw.util.pick.with_input guards the "prompt then act" picker keymaps: it must
-- call fn only for non-empty input, and pass the completion arg through to
-- vim.fn.input. Stub vim.fn.input to drive it; restore the stub after each test.

local pick = require("bw.util.pick")

describe("bw.util.pick.with_input", function()
  local orig_input
  local input_args

  before_each(function()
    input_args = nil
    orig_input = vim.fn.input
  end)

  after_each(function()
    vim.fn.input = orig_input
  end)

  local function stub_input(value)
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.fn.input = function(...)
      input_args = { ... }
      return value
    end
  end

  it("calls fn with the entered value for non-empty input", function()
    stub_input("/some/dir")
    local got
    pick.with_input("Directory: ", "dir", function(v)
      got = v
    end)
    assert.equals("/some/dir", got)
  end)

  it("passes the completion type through to vim.fn.input", function()
    stub_input("x")
    pick.with_input("Directory: ", "dir", function() end)
    assert.same({ "Directory: ", "", "dir" }, input_args)
  end)

  it("omits the completion args when none is given", function()
    stub_input("x")
    pick.with_input("Type: ", nil, function() end)
    assert.same({ "Type: " }, input_args)
  end)

  it("does not call fn on empty (cancelled) input", function()
    stub_input("")
    local called = false
    pick.with_input("Directory: ", "dir", function()
      called = true
    end)
    assert.is_false(called)
  end)
end)
