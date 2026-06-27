-- Exercises the custom "Diagnostic Virtual Text" toggle defined in
-- lua/plugins/diagnostics.lua. We stub the Snacks global so the spec's opts
-- function runs, capture the toggle config it builds, then drive its get/set
-- against the real vim.diagnostic API.

local function capture_toggle()
  local captured
  _G.Snacks = {
    toggle = {
      new = function(cfg)
        captured = cfg
        return { map = function() end }
      end,
      diagnostics = function()
        return { map = function() end }
      end,
    },
  }
  package.loaded["plugins.diagnostics"] = nil
  local spec = require("plugins.diagnostics")
  spec[1].opts()
  return captured
end

describe("diagnostics virtual_text toggle", function()
  local toggle

  before_each(function()
    toggle = capture_toggle()
    -- Start from a rich (table) virtual_text config, as LazyVim sets.
    vim.diagnostic.config({ virtual_text = { prefix = "X" } })
  end)

  it("get() reports a boolean, not the raw config value", function()
    assert.equals("boolean", type(toggle.get()))
    assert.is_true(toggle.get())
  end)

  it("disabling then re-enabling preserves the original table config", function()
    toggle.set(false)
    assert.is_false(vim.diagnostic.config().virtual_text)
    assert.is_false(toggle.get())

    toggle.set(true)
    assert.same({ prefix = "X" }, vim.diagnostic.config().virtual_text)
    assert.is_true(toggle.get())
  end)
end)
