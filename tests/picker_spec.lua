-- plugins/picker.lua must be importable as a plain lazy spec without snacks
-- being loaded yet, and its keymap RHS should be deferred functions rather than
-- values resolved at import time. (Run in the harness where snacks is absent.)

describe("plugins.picker spec", function()
  it("imports without snacks loaded", function()
    package.loaded["plugins.picker"] = nil
    assert.is_nil(package.loaded["snacks"])
    local ok, spec = pcall(require, "plugins.picker")
    assert.is_true(ok)
    assert.is_table(spec)
  end)

  it("picker keymap RHS are deferred functions", function()
    package.loaded["plugins.picker"] = nil
    local spec = require("plugins.picker")
    local snacks_spec = spec[1]
    assert.is_truthy(snacks_spec.keys)
    for _, k in ipairs(snacks_spec.keys) do
      assert.equals("function", type(k[2]))
    end
  end)
end)
