-- Exercises the "Diagnostic Virtual Text" toggle builder in
-- lua/bw/util/diagnostics.lua. The builder is pure (no Snacks/keymap side
-- effects), so we build the toggle config and drive its get/set straight
-- against the real vim.diagnostic API -- no Snacks stub, and no coupling to the
-- plugin spec's ordering.

local diagnostics = require("bw.util.diagnostics")

describe("diagnostics virtual_text toggle", function()
  local toggle

  -- These tests mutate the global vim.diagnostic config; snapshot the pristine
  -- config now (before any before_each runs) and restore it after each test so
  -- nothing leaks into other specs sharing this headless instance.
  local orig_config = vim.deepcopy(vim.diagnostic.config() or {})

  before_each(function()
    toggle = diagnostics.virtual_text_toggle()
    -- Start from a rich (table) virtual_text config, as LazyVim sets.
    vim.diagnostic.config({ virtual_text = { prefix = "X" } })
  end)

  after_each(function()
    vim.diagnostic.config(orig_config)
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
