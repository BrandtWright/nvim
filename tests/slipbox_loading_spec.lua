-- Regression: the slipbox plugin must load when a slip README is opened
-- directly (e.g. from the slips picker), not only via SlipNew/SlipEdit. The
-- save BufWriteCmd is registered in setup(), so if the plugin stays lazy when a
-- slip is opened some other way, `:w` writes the raw buffer and bypasses snote.

local spec = require("plugins.slipbox")[1]

local function has_key(s, lhs)
  for _, k in ipairs(s.keys or {}) do
    if k[1] == lhs then
      return true
    end
  end
  return false
end

-- Flatten lazy.nvim's `dependencies` (string | spec | list of either) into a
-- list of {name, dir} probes so we can assert none of them reference slipbox.
local function dep_refs(s)
  local deps = s.dependencies
  if deps == nil then
    return {}
  end
  -- A single spec table (has name/dir) rather than a list.
  if deps.name or deps.dir or deps[1] == nil then
    deps = { deps }
  end
  local refs = {}
  for _, d in ipairs(deps) do
    refs[#refs + 1] = type(d) == "string" and d or (d.name or d.dir or "")
  end
  return refs
end

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

-- Regression: the slips picker must NOT pull the slipbox plugin in as a snacks
-- dependency. snacks is eager-loaded, so a dependency edge would force-load
-- slipbox at startup and defeat its own cmd/event/keys lazy triggers. The
-- <leader>sn picker keymap instead lives on the slipbox spec, so invoking it
-- loads slipbox (-> setup()) before the picker's finder resolves slip paths.
describe("slipbox lazy wiring", function()
  it("is not declared as a snacks dependency", function()
    local slips = require("plugins.pickers.slips")[1]
    for _, ref in ipairs(dep_refs(slips)) do
      ---@diagnostic disable-next-line: redundant-parameter -- luassert allows a failure message
      assert.is_nil(ref:match("slipbox"), "slipbox must not be a snacks dependency, found: " .. ref)
    end
  end)

  it("owns the <leader>sn find-slip keymap so pressing it runs setup() first", function()
    ---@diagnostic disable-next-line: redundant-parameter -- luassert allows a failure message
    assert.is_true(has_key(spec, "<leader>sn"), "expected <leader>sn on the slipbox spec keys")
  end)
end)
