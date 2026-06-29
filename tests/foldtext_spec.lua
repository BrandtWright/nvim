-- bw.util.foldtext.build: the pure fold-text formatter behind
-- _G.TreesitterFoldText (config/options.lua). Window/buffer state is injected,
-- so the truncation + padding logic is testable without a real fold.

local ft = require("bw.util.foldtext")

describe("bw.util.foldtext.build", function()
  it("renders the trimmed first line with a [N lines] suffix", function()
    local out = ft.build({ line = "  hello  ", count = 3, width = 40 })
    assert.is_truthy(out:find("hello", 1, true))
    assert.is_truthy(out:find("[3 lines]", 1, true))
    assert.is_nil(out:find("  hello", 1, true)) -- leading whitespace trimmed
  end)

  it("right-pads a short line to fill the window width (minus fold column)", function()
    local out = ft.build({ line = "hello", count = 3, width = 40 })
    assert.equals(38, vim.fn.strdisplaywidth(out)) -- width - 2
    assert.is_truthy(out:match(" $")) -- padded with trailing spaces
  end)

  it("truncates an overflowing line with an ellipsis and does not overflow", function()
    local out = ft.build({ line = string.rep("x", 200), count = 10, width = 30 })
    assert.equals(28, vim.fn.strdisplaywidth(out)) -- exactly fills width - 2
    assert.is_truthy(out:find("x…", 1, true)) -- truncated, ellipsis appended
    assert.is_truthy(out:find("[10 lines]", 1, true))
  end)

  it("uses the line count in the suffix", function()
    local out = ft.build({ line = "abc", count = 7, width = 40 })
    assert.is_truthy(out:find("[7 lines]", 1, true))
  end)
end)
