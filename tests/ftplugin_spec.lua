-- Tests the config's after/ftplugin/* files by sourcing them directly into a
-- fresh buffer. This checks file validity (no load errors) and the buffer-local
-- effects, without depending on Neovim's filetype-detection machinery (which
-- plenary's headless environment does not fully drive).

local ROOT = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")

local function source_ftplugin(name)
  vim.cmd("enew")
  -- Wrap in a closure: vim.cmd is a callable table, not a bare function, so
  -- lua_ls rejects passing it straight to pcall (param-type-mismatch).
  return pcall(function()
    vim.cmd("source " .. ROOT .. "/after/ftplugin/" .. name)
  end)
end

describe("after/ftplugin/sql.vim", function()
  it("sources without error (was Lua in a vimscript file -> E499)", function()
    local ok, err = source_ftplugin("sql.vim")
    ---@diagnostic disable-next-line: redundant-parameter -- luassert is_true accepts a failure message
    assert.is_true(ok, tostring(err))
  end)

  it("sets a mysql-style commentstring", function()
    assert.is_true((source_ftplugin("sql.vim")))
    assert.equals("-- %s", vim.bo.commentstring)
    assert.equals("mysql", vim.g.sql_type_default)
  end)
end)

describe("after/ftplugin/term.vim", function()
  it("sources cleanly and defines no broken TermWhitespace autocmds", function()
    assert.is_true((source_ftplugin("term.vim")))
    -- The broken whitespace block (undefined hl groups, E488) was removed, so
    -- the augroup should no longer exist.
    local ok = pcall(vim.api.nvim_get_autocmds, { group = "TermWhitespace" })
    assert.is_false(ok)
  end)

  it("still sets the terminal-buffer options", function()
    source_ftplugin("term.vim")
    assert.is_false(vim.wo.number)
    assert.is_false(vim.wo.relativenumber)
    assert.equals(0, vim.wo.scrolloff)
  end)
end)

describe("after/ftplugin/python.vim", function()
  it("marks the overflow column buffer-locally instead of window-scoped :match", function()
    source_ftplugin("python.vim")
    assert.equals("81", vim.wo.colorcolumn)
    assert.equals(80, vim.bo.textwidth)
  end)
end)
