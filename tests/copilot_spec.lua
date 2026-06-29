-- Copilot costs money, so it must stay opt-in and dormant: kept OUT of the
-- blink completion menu (vim.g.ai_cmp = false) and inline suggestions present
-- but never auto-triggered. A regression here means Copilot could start billing
-- on every keystroke or completion popup.

describe("copilot stays opt-in and dormant", function()
  it("keeps AI out of the blink completion menu (vim.g.ai_cmp = false)", function()
    require("config.options")
    assert.is_false(vim.g.ai_cmp)
  end)

  it("configures inline suggestions as on-demand (enabled, no auto_trigger)", function()
    local spec = require("plugins.ai")[1]
    assert.equals("zbirenbaum/copilot.lua", spec[1])
    assert.is_true(spec.opts.suggestion.enabled)
    assert.is_false(spec.opts.suggestion.auto_trigger)
  end)

  it("does not blanket-disable Copilot for all filetypes", function()
    -- The old `filetypes = { ['*'] = false }` made Copilot attach to nothing,
    -- so even on-demand triggers/toggles were dead. Guard against its return.
    local ft = require("plugins.ai")[1].opts.filetypes
    assert.is_true(ft == nil or ft["*"] ~= false)
  end)
end)
