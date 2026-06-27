-- Regression guard, NOT a bug fix.
--
-- A review flagged the `ft`-scoped entries in these lazy `keys` specs (fm-nvim's
-- `q`, fugitive's pull/push) as creating GLOBAL maps. That is false: lazy.nvim's
-- keys handler only calls add() (global) in the `else` branch; when `ft` is set
-- it registers a FileType autocmd and sets the map buffer-local to that
-- filetype (lua/lazy/core/handler/keys.lua: `if keys.ft then ... else add()`).
--
-- These maps are destructive if global (q -> :q hijacks macro recording; pull/
-- push fire anywhere), so this spec locks in the invariant: they must keep `ft`.

local function find_spec(specs, repo)
  for _, s in ipairs(specs) do
    if s[1] == repo then
      return s
    end
  end
end

local function find_key(spec, lhs)
  for _, k in ipairs(spec.keys or {}) do
    if k[1] == lhs then
      return k
    end
  end
end

describe("destructive lazy keys stay filetype-scoped", function()
  it("fm-nvim 'q' is ft=Fm, so it is buffer-local not a global :q", function()
    local spec = find_spec(require("plugins.navigation"), "is0n/fm-nvim")
    assert.is_truthy(spec)
    local q = find_key(spec, "q")
    assert.is_truthy(q)
    assert.equals("Fm", q.ft)
  end)

  it("fugitive pull/push are ft=fugitive", function()
    local spec = find_spec(require("plugins.git"), "tpope/vim-fugitive")
    assert.is_truthy(spec)
    assert.equals("fugitive", find_key(spec, "<leader>gp").ft)
    assert.equals("fugitive", find_key(spec, "<leader>gP").ft)
  end)
end)
