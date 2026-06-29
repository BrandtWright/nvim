-- plenary must be declared as an explicit plugin spec: globals.lua's RELOAD
-- helper requires("plenary.reload"), and plenary is no longer pulled in
-- transitively (it used to ride along with telescope, since removed). If the
-- explicit entry (in plugins/lazyvim.lua) is ever dropped, RELOAD breaks --
-- this guards it.
--
-- Checks the DECLARED specs (walks the required plugins/* tables) rather than
-- grepping source text, so a mention in a comment can never satisfy it.

local ROOT = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")

-- Collect every string anywhere in the required plugins/* spec trees. Walking
-- the loaded tables (vs. reading files) means comments can't cause a false
-- match; over-collecting unrelated strings is harmless because the test only
-- asks whether a specific repo identifier is present. The `seen` guard avoids
-- cycles if a spec table ever references itself.
local function spec_strings()
  local acc, seen = {}, {}
  local function walk(node)
    if type(node) == "string" then
      acc[#acc + 1] = node
    elseif type(node) == "table" and not seen[node] then
      seen[node] = true
      for _, v in pairs(node) do
        walk(v)
      end
    end
  end
  for _, f in ipairs(vim.fn.globpath(ROOT .. "/lua/plugins", "**/*.lua", false, true)) do
    local mod = f:match("lua/(.*)%.lua$"):gsub("/", ".")
    package.loaded[mod] = nil
    local ok, spec = pcall(require, mod)
    if ok then
      walk(spec)
    end
  end
  return acc
end

describe("plenary is declared explicitly", function()
  it("appears as a repo in some plugin spec (globals.lua RELOAD depends on it)", function()
    local found = false
    for _, s in ipairs(spec_strings()) do
      if s:find("nvim%-lua/plenary%.nvim") then
        found = true
      end
    end
    assert.is_true(found)
  end)
end)
