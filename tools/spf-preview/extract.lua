-- Headless extractor for the spf preview page.
--
-- Resolves the theme through nvim -- the real assembler in `spf/init.lua` -- so
-- the preview shows exactly what the colorscheme computes, not a re-parse of the
-- Lua that could drift. Writes a JSON blob (palette + primitives + concept links
-- + fully-resolved highlight colors) to $SPF_PREVIEW_OUT.
--
-- Invoked by serve.py:
--   SPF_REPO=<repo> SPF_PREVIEW_OUT=<file> \
--     nvim --headless --clean -n -c 'luafile extract.lua' -c 'qa!'

local repo = vim.env.SPF_REPO or vim.fn.getcwd()
vim.opt.runtimepath:append(repo) -- so require("spf") finds repo/lua/spf/
vim.o.termguicolors = true

-- Assemble + paint. apply() returns { colors, highlights (primitives), links }
-- and, crucially, writes every group with nvim_set_hl so we can read concrete
-- resolved colors back out below.
local theme = require("spf").apply()

local function hex(n)
  if type(n) ~= "number" then
    return nil
  end
  return string.format("#%06x", n)
end

-- Concrete gui attributes for a highlight group (links followed).
local function resolve(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if not ok or type(hl) ~= "table" then
    return nil
  end
  local out = { fg = hex(hl.fg), bg = hex(hl.bg), sp = hex(hl.sp) }
  for _, a in ipairs({
    "bold",
    "italic",
    "underline",
    "undercurl",
    "underdouble",
    "underdotted",
    "strikethrough",
    "reverse",
  }) do
    if hl[a] then
      out[a] = true
    end
  end
  return out
end

-- palette: name -> hex
local palette = {}
for k, v in pairs(theme.colors) do
  if type(v) == "string" then
    palette[k] = v
  end
end

-- primitives: name -> declared spec fields + resolved concrete colors
local primitives = {}
for name, spec in pairs(theme.highlights) do
  local entry = { resolved = resolve(name) }
  if type(spec) == "table" then
    for k, v in pairs(spec) do
      entry[k] = v
    end
  end
  primitives[name] = entry
end

-- links: group -> target concept/group name
local links = {}
for g, t in pairs(theme.links) do
  if type(t) == "string" then
    links[g] = t
  end
end

-- resolved: concrete color for every primitive, every linked group, and the
-- core groups the page renders explicitly.
local resolved = {}
local function want(name)
  if resolved[name] == nil then
    resolved[name] = resolve(name)
  end
end
for g in pairs(primitives) do
  want(g)
end
for g in pairs(links) do
  want(g)
end
for _, g in ipairs({
  "Normal",
  "NormalFloat",
  "FloatBorder",
  "FloatTitle",
  "CursorLine",
  "CursorLineNr",
  "Visual",
  "Pmenu",
  "PmenuSel",
  "PmenuSbar",
  "LineNr",
  "Comment",
  "Keyword",
  "Function",
  "String",
  "Type",
  "Constant",
  "Number",
  "Boolean",
  "Statement",
  "Conditional",
  "Operator",
  "Identifier",
  "PreProc",
  "Special",
  "Title",
  "Directory",
  "DiagnosticError",
  "DiagnosticWarn",
  "DiagnosticInfo",
  "DiagnosticHint",
  "DiagnosticOk",
  "DiffAdd",
  "DiffChange",
  "DiffDelete",
  "DiffText",
  "StatusLine",
  "StatusLineNC",
  "StatusLineTerm",
  "WinBar",
  "WinBarNC",
  "TabLine",
  "TabLineSel",
}) do
  want(g)
end

local out = {
  palette = palette,
  primitives = primitives,
  links = links,
  resolved = resolved,
  normal = resolve("Normal"),
}

local outpath = vim.env.SPF_PREVIEW_OUT or (repo .. "/tools/spf-preview/.colors.json")
vim.fn.writefile({ vim.json.encode(out) }, outpath)
