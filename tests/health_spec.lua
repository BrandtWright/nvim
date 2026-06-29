-- bw.health: classification logic for :checkhealth bw.
--
-- Exercises the pure M.evaluate (probe injected, no real PATH lookups) and
-- guards the inventory's shape. Doubles as the baseline proof that the harness
-- can require a config module and run against the real Neovim API headlessly.

local health = require("bw.health")

describe("bw.health inventory", function()
  it("every entry has a name, a known level, and a reason", function()
    for _, t in ipairs(health.tools) do
      assert.equals("string", type(t.name))
      assert.is_truthy(t.name ~= "", "tool name is empty")
      assert.is_truthy(t.level == "required" or t.level == "optional", "bad level: " .. tostring(t.level))
      assert.equals("string", type(t.reason))
      assert.is_truthy(t.reason ~= "", "reason is empty for " .. t.name)
    end
  end)

  it("names are unique", function()
    local seen = {}
    for _, t in ipairs(health.tools) do
      assert.is_nil(seen[t.name], "duplicate tool: " .. t.name)
      seen[t.name] = true
    end
  end)
end)

describe("bw.health.evaluate", function()
  local spec = {
    { name = "alpha", level = "required", reason = "r1" },
    { name = "beta", level = "optional", reason = "r2" },
    { name = "gamma", level = "required", reason = "r3" },
  }

  it("marks a present tool ok regardless of level", function()
    local results = health.evaluate(spec, function()
      return true
    end)
    for _, r in ipairs(results) do
      assert.is_true(r.present)
      assert.equals("ok", r.status)
    end
  end)

  it("errors on a missing required tool, warns on a missing optional one", function()
    local present = { alpha = true } -- beta and gamma missing
    local results = health.evaluate(spec, function(name)
      return present[name] == true
    end)
    local by_name = {}
    for _, r in ipairs(results) do
      by_name[r.name] = r
    end
    assert.equals("ok", by_name.alpha.status)
    assert.equals("warn", by_name.beta.status) -- optional, missing
    assert.equals("error", by_name.gamma.status) -- required, missing
  end)

  it("preserves order and carries through name/level/reason", function()
    local results = health.evaluate(spec, function()
      return false
    end)
    assert.equals(#spec, #results)
    for i, r in ipairs(results) do
      assert.equals(spec[i].name, r.name)
      assert.equals(spec[i].level, r.level)
      assert.equals(spec[i].reason, r.reason)
    end
  end)
end)
