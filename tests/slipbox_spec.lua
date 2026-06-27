-- Path handling for the slipbox save autocmd. The slipbox root is deliberately
-- given Lua-pattern magic characters ("." and "-") so the test fails if the
-- root is interpolated into a pattern without vim.pesc.

local slipbox = require("user.slipbox")

-- tempname() is absolute; the suffix adds magic chars to the directory name.
local ROOT = vim.fs.normalize(vim.fn.tempname() .. "-slip.box")
vim.fn.mkdir(ROOT, "p")
slipbox.setup({ slipbox_dir = ROOT })

describe("slipbox.slip_id_from_path", function()
  it("extracts the id from a slip README path", function()
    assert.equals("a1b2", slipbox.slip_id_from_path(ROOT .. "/a1b2/README.md"))
  end)

  it("handles ids containing hyphens (magic char in root and id)", function()
    assert.equals("2026-06-27", slipbox.slip_id_from_path(ROOT .. "/2026-06-27/README.md"))
  end)

  it("returns nil for paths outside the slipbox", function()
    assert.is_nil(slipbox.slip_id_from_path("/somewhere/else/x/README.md"))
  end)

  it("returns nil for non-slip paths inside the slipbox", function()
    assert.is_nil(slipbox.slip_id_from_path(ROOT .. "/a/b/README.md"))
    assert.is_nil(slipbox.slip_id_from_path(ROOT .. "/a1b2/notes.md"))
  end)
end)

describe("slipbox save autocmd", function()
  it("registers BufWriteCmd with the resolved absolute root in its pattern", function()
    local aus = vim.api.nvim_get_autocmds({ group = "SlipWrite", event = "BufWriteCmd" })
    assert.is_true(#aus >= 1)
    -- pattern must contain the absolute root (plain find, not a pattern match)
    assert.is_truthy(aus[1].pattern:find(ROOT, 1, true))
    assert.is_nil(aus[1].pattern:find("~", 1, true))
  end)
end)
