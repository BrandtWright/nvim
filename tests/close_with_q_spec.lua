-- bw.util.close-with-q: registers a buffer-local `q` -> close for the given
-- filetypes via a FileType autocmd, and actually closes the window.

local close_with_q = require("bw.util.close-with-q")

describe("bw.util.close-with-q", function()
  before_each(function()
    close_with_q.setup({ "bwqtest" })
  end)

  it("maps q buffer-local only for configured filetypes", function()
    vim.cmd("botright new")
    local buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].filetype = "bwqtest" -- fires the FileType autocmd

    local m = vim.fn.maparg("q", "n", false, true)
    assert.equals(1, m.buffer) -- buffer-local, not global
    assert.equals("function", type(m.callback))
    vim.cmd("close")
  end)

  it("does not map q for other filetypes", function()
    vim.cmd("botright new")
    vim.bo.filetype = "some_other_ft"
    local m = vim.fn.maparg("q", "n", false, true)
    -- no mapping at all -> maparg returns an empty dict
    assert.is_nil(m.buffer)
    assert.is_nil(m.callback)
    vim.cmd("close")
  end)

  it("q actually closes the window", function()
    vim.cmd("botright new")
    local buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].filetype = "bwqtest"
    local before = #vim.api.nvim_tabpage_list_wins(0)

    local m = vim.fn.maparg("q", "n", false, true)
    m.callback()

    assert.equals(before - 1, #vim.api.nvim_tabpage_list_wins(0))
  end)
end)
