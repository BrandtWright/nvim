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

  it("ChatGPT declares plenary explicitly", function()
    local specs = require("plugins.ai")
    local chatgpt
    for _, s in ipairs(specs) do
      if s[1] == "jackMort/ChatGPT.nvim" then
        chatgpt = s
      end
    end
    assert.is_truthy(chatgpt)
    assert.is_truthy(vim.tbl_contains(chatgpt.dependencies or {}, "nvim-lua/plenary.nvim"))
  end)
end)
