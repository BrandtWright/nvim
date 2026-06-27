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
  it("fm-nvim defines no global 'q' map", function()
    -- The old `q` entry (mode=n, ft=Fm) never fired: fm-nvim runs its file
    -- managers in terminal-insert mode, so a normal-mode q went to the program.
    -- It was removed; per-filetype q-to-close belongs in after/ftplugin or a
    -- lazy spec's keys with ft=, not here.
    local spec = find_spec(require("plugins.navigation"), "is0n/fm-nvim")
    assert.is_truthy(spec)
    assert.is_nil(find_key(spec, "q"))
  end)

  it("fugitive pull/push are ft=fugitive", function()
    local spec = find_spec(require("plugins.git"), "tpope/vim-fugitive")
    assert.is_truthy(spec)
    assert.equals("fugitive", find_key(spec, "<leader>gp").ft)
    assert.equals("fugitive", find_key(spec, "<leader>gP").ft)
  end)
end)
