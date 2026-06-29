-- The colorizer must be installed idiomatically with an opts table (so lazy
-- runs require("colorizer").setup(opts)), lazy-loaded rather than eager, and
-- configured not to highlight bare color names. The spec is located by repo
-- suffix, so the exact fork owner is intentionally not asserted.

local function colorizer_spec()
  for _, s in ipairs(require("plugins.ui")) do
    local repo = s[1]
    if type(repo) == "string" and repo:match("nvim%-colorizer%.lua$") then
      return s
    end
  end
end

describe("nvim-colorizer spec", function()
  local spec = colorizer_spec()

  it("has an opts table so lazy calls setup(), and is lazy-loaded", function()
    assert.is_truthy(spec)
    assert.equals("table", type(spec.opts))
    assert.is_truthy(spec.event or spec.cmd or spec.keys or spec.ft)
  end)

  it("disables highlighting of bare color names", function()
    assert.is_false(spec.opts.user_default_options.names)
  end)
end)
