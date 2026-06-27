-- Tests the config's after/ftplugin/* files by sourcing them directly into a
-- fresh buffer. This checks file validity (no load errors) and the buffer-local
-- effects, without depending on Neovim's filetype-detection machinery (which
-- plenary's headless environment does not fully drive).

local ROOT = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")

local function source_ftplugin(name)
  vim.cmd("enew")
  return pcall(vim.cmd, "source " .. ROOT .. "/after/ftplugin/" .. name)
end

describe("after/ftplugin/sql.vim", function()
  it("sources without error (was Lua in a vimscript file -> E499)", function()
    local ok, err = source_ftplugin("sql.vim")
    assert.is_true(ok, tostring(err))
  end)

  it("sets a mysql-style commentstring", function()
    assert.is_true((source_ftplugin("sql.vim")))
    assert.equals("-- %s", vim.bo.commentstring)
    assert.equals("mysql", vim.g.sql_type_default)
  end)
end)
