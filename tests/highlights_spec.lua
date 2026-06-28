local hl = require("bw.util.highlights")

describe("bw.util.highlights.get_attribute", function()
  it("returns a hex string for a set attribute, nil otherwise", function()
    vim.api.nvim_set_hl(0, "BwTestGroup", { fg = 0xff0000 })
    assert.equals("#ff0000", hl.get_attribute("BwTestGroup", "fg"))
    assert.is_nil(hl.get_attribute("BwTestGroup", "bg"))
  end)
end)

describe("bw.util.highlights.on_colorscheme", function()
  it("applies fn immediately and again on ColorScheme", function()
    local count = 0
    hl.on_colorscheme("BwTestHl1", function()
      count = count + 1
    end)
    assert.equals(1, count) -- applied now
    vim.api.nvim_exec_autocmds("ColorScheme", { group = "BwTestHl1" })
    assert.equals(2, count) -- re-applied on colorscheme change
  end)

  it("does not accumulate duplicate autocmds on re-registration", function()
    local fn = function() end
    hl.on_colorscheme("BwTestHl2", fn)
    hl.on_colorscheme("BwTestHl2", fn)
    local aus = vim.api.nvim_get_autocmds({ group = "BwTestHl2", event = "ColorScheme" })
    assert.equals(1, #aus)
  end)

  it("re-applies forced links after a colorscheme is sourced (the real use case)", function()
    -- forced links get wiped by `:colorscheme`; on_colorscheme must restore them
    hl.on_colorscheme("BwTestHl3", function()
      vim.cmd("hi! link BwLinkSrc Comment")
    end)
    assert.equals("Comment", vim.api.nvim_get_hl(0, { name = "BwLinkSrc" }).link)
    vim.cmd("colorscheme habamax") -- fires ColorScheme -> re-applies
    assert.equals("Comment", vim.api.nvim_get_hl(0, { name = "BwLinkSrc" }).link)
  end)
end)
