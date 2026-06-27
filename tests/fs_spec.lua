-- Baseline spec: proves the harness can require config modules and exercise
-- real Neovim API headlessly. Also locks in the Section 1 buff_exceeds_size fix.

local fs = require("bw.util.fs")

-- Config root, derived from this spec's own path (tests/ -> parent).
local ROOT = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")

describe("bw.util.fs", function()
  it("is_directory: true for a real dir, false otherwise", function()
    assert.is_true(fs.is_directory(ROOT))
    assert.is_false(fs.is_directory(ROOT .. "/definitely-not-here"))
    assert.is_false(fs.is_directory(nil))
  end)

  it("is_file: true for a real file, false for a dir", function()
    assert.is_true(fs.is_file(ROOT .. "/init.lua"))
    assert.is_false(fs.is_file(ROOT))
  end)

  it("buff_exceeds_size: returns a boolean, never nil", function()
    local buf = vim.api.nvim_create_buf(false, true)
    -- Unnamed scratch buffer has no file on disk -> fs_stat fails.
    local result = fs.buff_exceeds_size(buf, 10)
    assert.equals("boolean", type(result)) -- regression: used to return nil
    assert.is_false(result)
  end)
end)
