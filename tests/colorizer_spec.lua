-- The colorizer should be the maintained catgoose fork, installed idiomatically
-- with an opts table (so lazy runs require("colorizer").setup(opts)) and
-- lazy-loaded rather than eager.

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

  it("uses the maintained catgoose fork (not stale norcalli)", function()
    assert.is_truthy(spec)
    assert.equals("catgoose/nvim-colorizer.lua", spec[1])
  end)

  it("has an opts table so lazy calls setup(), and is lazy-loaded", function()
    assert.equals("table", type(spec.opts))
    assert.is_truthy(spec.event or spec.cmd or spec.keys or spec.ft)
  end)

  it("disables highlighting of bare color names", function()
    assert.is_false(spec.opts.user_default_options.names)
  end)
end)
