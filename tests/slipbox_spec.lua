-- Path handling for the slipbox save autocmd. The slipbox root is deliberately
-- given Lua-pattern magic characters ("." and "-") so the test fails if the
-- root is interpolated into a pattern without vim.pesc.

local slipbox = require("user.slipbox")

-- tempname() is absolute; the suffix adds magic chars to the directory name.
local ROOT = vim.fs.normalize(vim.fn.tempname() .. "-slip.box")
vim.fn.mkdir(ROOT, "p")
slipbox.setup({ slipbox_dir = ROOT })

-- Remove the temp slipbox on exit (plenary quits via :cquit, which fires VimLeavePre).
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.fn.delete(ROOT, "rf")
  end,
})

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

describe("slipbox.extract_yaml_related", function()
  it("parses an inline list (related: [a, b])", function()
    assert.same({ "foo", "bar" }, slipbox.extract_yaml_related({
      "---",
      "related: [foo, bar]",
      "---",
    }))
  end)

  it("parses a block list (related: then - items)", function()
    assert.same({ "foo", "bar" }, slipbox.extract_yaml_related({
      "---",
      "title: x",
      "related:",
      "  - foo",
      "  - bar",
      "---",
    }))
  end)

  it("stops a block list at the next yaml key", function()
    assert.same({ "foo" }, slipbox.extract_yaml_related({
      "---",
      "related:",
      "  - foo",
      "tags: [t]",
      "---",
    }))
  end)

  it("returns empty when there is no front matter", function()
    assert.same({}, slipbox.extract_yaml_related({ "# Title", "related: [x]" }))
  end)

  it("returns empty when front matter has no related field", function()
    assert.same({}, slipbox.extract_yaml_related({ "---", "title: x", "---" }))
  end)
end)

describe("slipbox.parse_slip_lines", function()
  it("parses id, title and tags from a tab-separated line", function()
    assert.same(
      { { id = "001", title = "First", tags = "tag1 tag2" } },
      slipbox.parse_slip_lines({ "001\tFirst\ttag1 tag2" })
    )
  end)

  it("defaults a missing title and tags to empty strings", function()
    assert.same(
      { { id = "002", title = "Second", tags = "" }, { id = "003", title = "", tags = "" } },
      slipbox.parse_slip_lines({ "002\tSecond", "003" })
    )
  end)

  it("skips blank lines (e.g. a trailing newline from snote)", function()
    assert.same(
      { { id = "001", title = "First", tags = "" } },
      slipbox.parse_slip_lines({ "001\tFirst", "" })
    )
  end)

  it("returns empty for empty input", function()
    assert.same({}, slipbox.parse_slip_lines({}))
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

describe("slipbox.get_related_slips", function()
  it("returns empty for a buffer that is not a slip", function()
    vim.cmd("enew")
    assert.same({}, slipbox.get_related_slips())
  end)

  it("reads related ids from the front matter of a slip buffer", function()
    vim.cmd("enew")
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(buf, ROOT .. "/abc/README.md")
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "---", "related: [foo, bar]", "---" })
    assert.same({ "foo", "bar" }, slipbox.get_related_slips())
  end)
end)
