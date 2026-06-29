-- pickers/slips.lua: the slipbox and related_slips sources relied on the
-- default file-open confirm (their items have a `file` field), so the per-item
-- `action` closures they also carried were dead code. Only slip_links sets
-- confirm = "item_action" and genuinely needs its action. This pins that down.

package.loaded["user.slipbox"] = {
  get_slipbox_path = function()
    return "/tmp/slipbox"
  end,
  list_slips = function()
    return {
      { id = "001", title = "First", tags = "tag1" },
      { id = "002", title = "Second", tags = "" },
    }
  end,
  get_related_slips = function()
    return { "002" }
  end,
  get_slip_path = function(id)
    return "/tmp/slipbox/" .. id .. "/README.md"
  end,
}

local function sources()
  package.loaded["plugins.pickers.slips"] = nil
  local spec = require("plugins.pickers.slips")[1]
  return spec.opts(nil, {}).picker.sources
end

describe("slips picker sources", function()
  local src = sources()

  it("slipbox items rely on default file-open confirm (no dead action)", function()
    assert.is_nil(src.slipbox.confirm)
    local items = src.slipbox.finder()
    assert.is_true(#items > 0)
    assert.is_truthy(items[1].file)
    assert.is_nil(items[1].action)
    -- text is "title tags" when the slip has tags
    assert.equals("First tag1", items[1].text)
  end)

  it("related_slips items have no dead action either", function()
    local items = src.related_slips.finder()
    assert.is_true(#items > 0)
    assert.is_nil(items[1].action)
    -- a tagless slip renders just the title (no trailing space)
    assert.equals("Second", items[1].text)
  end)

  it("slip_links keeps confirm=item_action and a real action", function()
    assert.equals("item_action", src.slip_links.confirm)
    local items = src.slip_links.finder()
    assert.is_true(#items > 0)
    assert.equals("function", type(items[1].action))
  end)
end)
