-- Regression: the slipbox plugin must load when a slip README is opened
-- directly (e.g. from the slips picker), not only via SlipNew/SlipEdit. The
-- save BufWriteCmd is registered in setup(), so if the plugin stays lazy when a
-- slip is opened some other way, `:w` writes the raw buffer and bypasses snote.

local spec = require("plugins.slipbox")[1]

describe("slipbox plugin loading", function()
  it("loads on BufReadPre for a slip README so the save autocmd is registered", function()
    local events = type(spec.event) == "table" and spec.event or { spec.event }
    local found = false
    for _, e in ipairs(events) do
      if type(e) == "string" and e:match("^BufReadPre .+/%*/README%.md$") then
        found = true
      end
    end
    ---@diagnostic disable-next-line: redundant-parameter -- luassert is_true accepts a failure message
    assert.is_true(found, "expected a BufReadPre <slipbox>/*/README.md lazy event trigger")
  end)
end)
