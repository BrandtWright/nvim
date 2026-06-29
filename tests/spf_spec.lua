-- colors/spf.lua: COLOR-INDEPENDENT structural guards.
--
-- These tests deliberately never assert on a color value or on what a group
-- links *to* in appearance. They assert STRUCTURE: that the scheme loads, that
-- every link resolves to a real definition, and that the load-bearing groups
-- stay owned by the theme. Retune the palette or repoint a link to another valid
-- target and these stay green; only a real regression -- a load error, a typo'd
-- link target, or a group silently dropping out of coverage -- turns them red.
--
-- Sourcing colors/spf.lua applies the scheme (a harmless side effect headless)
-- AND returns its source-of-truth tables { colors, highlights, links }; that
-- return value is how we inspect what spf ITSELF defines rather than the loaded
-- highlight state (Neovim backfills defaults for standard groups, so querying
-- the live state can't tell spf's coverage from Neovim's).

local spf_path = vim.api.nvim_get_runtime_file("colors/spf.lua", false)[1]
assert(spf_path, "colors/spf.lua not found on the runtimepath")

local function load_theme()
  return loadfile(spf_path)()
end

-- spf sets the global colorscheme; restore it so it does not leak to other specs
-- sharing this headless instance.
local orig_colors = vim.g.colors_name
local function restore_colorscheme()
  if vim.g.colors_name ~= orig_colors then
    pcall(vim.cmd.colorscheme, orig_colors or "default")
  end
end

describe("colors/spf loading", function()
  after_each(restore_colorscheme)

  it("sources without error and returns its tables", function()
    local ok, theme = pcall(load_theme)
    assert.is_true(ok)
    assert.is_table(theme.colors)
    assert.is_table(theme.highlights)
    assert.is_table(theme.links)
  end)

  it("applies via :colorscheme without error and paints Normal", function()
    assert.is_true(pcall(vim.cmd.colorscheme, "spf"))
    -- spf owns Normal, so after applying it must resolve to a concrete spec.
    assert.is_false(vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = "Normal" })))
  end)

  it("sets all 16 terminal colors", function()
    load_theme()
    for i = 0, 15 do
      local c = vim.g["terminal_color_" .. i]
      ---@diagnostic disable-next-line: redundant-parameter -- luassert allows a failure message
      assert.is_truthy(c, "terminal_color_" .. i .. " is unset")
      assert.equals("string", type(c))
    end
  end)
end)

describe("colors/spf link integrity", function()
  after_each(restore_colorscheme)

  -- A "defined" group name is anything spf lists: a presentational spec
  -- (highlights key), a real link, OR a `{}` deferral marker in the links table
  -- (spf lists some groups as `{}` to mean "leave at Neovim's default" -- the
  -- apply loop skips them, but the NAME is intentionally claimed, so a real link
  -- may legitimately target one and have Neovim resolve it).
  local function defined_set(theme)
    local defined = {}
    for name in pairs(theme.highlights) do
      defined[name] = true
    end
    for name in pairs(theme.links) do
      defined[name] = true
    end
    return defined
  end

  it("has no dangling links -- every target is a group spf defines", function()
    local theme = load_theme()
    local defined = defined_set(theme)
    local dangling = {}
    for group, target in pairs(theme.links) do
      -- Only real (string) links have a target to resolve; `{}` deferrals don't.
      if type(target) == "string" and target ~= "" and not defined[target] then
        dangling[#dangling + 1] = string.format("%s -> %s", group, target)
      end
    end
    table.sort(dangling)
    -- A typo like the historical `nothing_on_daark_*` would surface here.
    assert.same({}, dangling)
  end)
end)

describe("colors/spf coverage", function()
  after_each(restore_colorscheme)

  -- Load-bearing groups spf must own (no graceful Neovim default for this theme's
  -- identity): core UI chrome, base syntax, and the diagnostic set. Treesitter
  -- @captures are intentionally excluded -- many defer to Neovim's default links
  -- (@function -> Function etc.), and guarding the base groups already covers a
  -- regression in the layer they inherit from. This is a ratchet: a group
  -- silently dropping out (the historical TabLine typo) fails the test until the
  -- removal is confirmed intentional and the list updated.
  local LOAD_BEARING = {
    "Normal",
    "NormalFloat",
    "Comment",
    "Constant",
    "String",
    "Identifier",
    "Function",
    "Statement",
    "Keyword",
    "Type",
    "Special",
    "Error",
    "Todo",
    "StatusLine",
    "LineNr",
    "CursorLine",
    "CursorLineNr",
    "Visual",
    "Search",
    "Pmenu",
    "PmenuSel",
    "TabLine",
    "WinSeparator",
    "FloatBorder",
    "DiagnosticError",
    "DiagnosticWarn",
    "DiagnosticInfo",
    "DiagnosticHint",
  }

  it("owns every load-bearing UI, syntax and diagnostic group", function()
    local theme = load_theme()
    local owned = {}
    for name in pairs(theme.highlights) do
      owned[name] = true
    end
    for name, target in pairs(theme.links) do
      if type(target) == "string" and target ~= "" then
        owned[name] = true
      end
    end
    local missing = {}
    for _, group in ipairs(LOAD_BEARING) do
      if not owned[group] then
        missing[#missing + 1] = group
      end
    end
    table.sort(missing)
    assert.same({}, missing)
  end)
end)

describe("colors/spf section assembly", function()
  after_each(restore_colorscheme)

  -- The assembler discovers lua/spf/groups/*.lua dynamically (no hardcoded list),
  -- so guard that every section file is actually merged into links. A discovery
  -- bug that dropped a non-load-bearing section (e.g. filetypes) would otherwise
  -- slip past the link-integrity and coverage specs, since those sections are
  -- mostly self-contained leaf links.
  it("merges every groups/*.lua file into links", function()
    local theme = load_theme()
    local files = vim.api.nvim_get_runtime_file("lua/spf/groups/*.lua", true)
    ---@diagnostic disable-next-line: redundant-parameter -- luassert allows a failure message
    assert.is_true(#files > 0, "no group files found on the runtimepath")
    for _, path in ipairs(files) do
      local name = path:match("([^/\\]+)%.lua$")
      if name ~= "init" then
        -- Load the file directly (independent of the assembler) and confirm
        -- each of its keys made it into the merged table.
        for group in pairs(dofile(path)) do
          assert.is_truthy(
            theme.links[group] ~= nil,
            ---@diagnostic disable-next-line: redundant-parameter -- luassert allows a failure message
            string.format("%s from groups/%s missing in assembled links", group, name)
          )
        end
      end
    end
  end)
end)
