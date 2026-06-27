-- nvim-colorizer.lua does nothing unless require("colorizer").setup() runs.
-- This pins that the ui.lua spec actually calls setup() in its config.

local function colorizer_spec()
  for _, s in ipairs(require("plugins.ui")) do
    if s[1] == "norcalli/nvim-colorizer.lua" then
      return s
    end
  end
end

describe("nvim-colorizer spec", function()
  it("calls colorizer.setup() in its config", function()
    local called = false
    package.loaded["colorizer"] = {
      setup = function()
        called = true
      end,
    }
    local spec = colorizer_spec()
    assert.is_truthy(spec)
    assert.equals("function", type(spec.config))
    spec.config(spec, {})
    assert.is_true(called)
  end)
end)
