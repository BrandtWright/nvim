-- Guards the telescope -> snacks migration: no plugin spec may reference the
-- telescope repo (which would make lazy reinstall it), and ChatGPT must declare
-- plenary explicitly (telescope used to provide it transitively).

local ROOT = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")

describe("telescope removal", function()
  it("no plugin spec references the telescope repo", function()
    local files = vim.fn.globpath(ROOT .. "/lua/plugins", "**/*.lua", false, true)
    local offenders = {}
    for _, f in ipairs(files) do
      local content = table.concat(vim.fn.readfile(f), "\n")
      if content:find("nvim%-telescope/telescope") then
        table.insert(offenders, vim.fn.fnamemodify(f, ":t"))
      end
    end
    assert.same({}, offenders)
  end)

  it("init.lua does not import the telescope picker extra", function()
    local content = table.concat(vim.fn.readfile(ROOT .. "/init.lua"), "\n")
    assert.is_nil(content:find("extras%.editor%.telescope"))
  end)

  it("plenary is declared explicitly (globals.lua RELOAD depends on it)", function()
    local files = vim.fn.globpath(ROOT .. "/lua/plugins", "**/*.lua", false, true)
    local found = false
    for _, f in ipairs(files) do
      if table.concat(vim.fn.readfile(f), "\n"):find("nvim%-lua/plenary%.nvim") then
        found = true
      end
    end
    assert.is_true(found)
  end)
end)
