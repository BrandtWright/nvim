-- Baseline spec: proves the harness can require config modules and exercise
-- the real Neovim API headlessly. Also locks in the buff_exceeds_size fix.

local fs = require("bw.util.fs")

describe("bw.util.fs", function()
  it("buff_exceeds_size: false for an unnamed buffer (no file to stat)", function()
    local buf = vim.api.nvim_create_buf(false, true)
    -- Unnamed scratch buffer has no file on disk -> fs_stat fails.
    local result = fs.buff_exceeds_size(buf, 10)
    assert.equals("boolean", type(result)) -- regression: used to return nil
    assert.is_false(result)
  end)

  it("buff_exceeds_size: true when the backing file exceeds the threshold", function()
    local path = vim.fn.tempname()
    local f = assert(io.open(path, "w"))
    f:write(string.rep("x", 1024))
    f:close()

    local buf = vim.fn.bufadd(path)
    vim.fn.bufload(buf)

    assert.is_true(fs.buff_exceeds_size(buf, 512))
    assert.is_false(fs.buff_exceeds_size(buf, 4096))

    os.remove(path)
  end)
end)
