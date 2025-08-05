-------------------------------------------------------------------------------
-- SPF
--
-- A colorscheme for Neovim
--
-- TODO: implement `g:terminal_color_*` (see: https://tinyurl.com/y78ntvjk)

-- see: :help 'highlight'
-- see: :edit $VIMRUNTIME/colors/README.txt
-- see: :edit $VIMRUNTIME/doc/dev_theme.txt
--
-- |highlight-groups| (Normal, Comment, etc.)
-- |group-name| (Keyword, Function, etc.)
-- |diagnostic-highlights| (DiagnosticError, DiagnosticWarn, etc)
-- |treesitter-highlight-groups| (@variable, @variable.builtin, etc)
-- |lsp-semantic-highlight| (@lsp.type.function, @lsp.type.variable.lua, etc)
-- |lsp-highlight| (LspReferenceText, LspReferenceRead, etc)
-------------------------------------------------------------------------------

local colors = {
  foreground = "#ebdbb2",
  background = "#191816",
  cursor_line = "#1f1d1b",

  red_dark = "#b25f57",
  red = "#bd7671",
  red_bright = "#ffa099",

  orange_dark = "#a1633f",
  orange = "#ce9178",
  orange_bright = "#f29950",

  yellow_dark = "#b9b237",
  yellow = "#c2c27c",
  yellow_bright = "#fcfca4",

  chartreuse_dark = "#758e57",
  chartreuse = "#91b76b",
  chartreuse_bright = "#cfeaa0",

  green_dark = "#4b6550",
  green = "#769482",
  green_bright = "#b9d9b8",

  spring_dark = "#4f766e",
  spring = "#6da89e",
  spring_bright = "#a9d5c8",

  cyan_dark = "#536a71",
  cyan = "#7b919e",
  cyan_bright = "#a7cacc",

  azure_dark = "#45667e",
  azure = "#5f87a6",
  azure_bright = "#a2c5e4",

  blue_dark = "#3f6999",
  blue = "#5692db",
  blue_bright = "#77b3fc",

  violet_dark = "#59497c",
  violet = "#8a7b9e",
  violet_bright = "#eebaff",

  magenta_dark = "#5f4469",
  magenta = "#8f7099",
  magenta_bright = "#c99fd6",

  rose_dark = "#94586b",
  rose = "#c08081",
  rose_bright = "#e084a3",

  black_dark = "#121210",
  black = "#0e0d0c",
  black_bright = "#737373",

  white_dark = "#a89f91",
  white = "#ebdbb2",
  white_bright = "#f2e8ce",

  ui_primary_foreground = "#a6977c",
  ui_primary_background = "#2c2826",
  ui_secondary_background = "#504945",
  ui_tertiary_background = "#a89984",
}

local spf_highlights = {

  -- UI
  foreground_on_background = { fg = colors.foreground, bg = colors.background },

  -- Color Palette
  cyan_bright = { fg = colors.cyan_bright, bg = "" },
  black_bright_italic = { fg = colors.black_bright, bg = "", italic = true },
  orange = { fg = colors.orange, bg = "" },
  yellow = { fg = colors.yellow, bg = "" },
  magenta_bright = { fg = colors.magenta_bright, bg = "" },
  blue = { fg = colors.blue, bg = "" },
}

local canonical_links = {

  ------------------------------------------------------------------------------
  -- Syntax Highlight Groups                             see: :help 'group-name'
  ------------------------------------------------------------------------------

  -- any comment
  Comment = spf_highlights.black_bright_italic,
  -- any constant
  Constant = spf_highlights.cyan_bright,
  -- a string constant: "this is a string"
  String = spf_highlights.orange,
  -- function name (also: methods for classes)
  Function = spf_highlights.yellow,
  -- any statement (flow control, return, etc.)
  Statement = spf_highlights.magenta_bright,
  -- any other keyword
  Keyword = spf_highlights.blue,

  ------------------------------------------------------------------------------
  -- UI Highlight Groups                           see: :help 'highlight-groups'
  ------------------------------------------------------------------------------

  -- Normal text.
  Normal = spf_highlights.foreground_on_background,
}

local derived_links = {

  ------------------------------------------------------------------------------
  -- Syntax Highlight Groups                             see: :help 'group-name'
  ------------------------------------------------------------------------------

  -- any variable name
  Identifier = canonical_links.Normal,

  -- a character constant: 'c', '\n'
  Character = canonical_links.Constant,
  -- a number constant: 234, 0xff
  Number = canonical_links.Constant,
  -- a boolean constant: TRUE, false
  Boolean = canonical_links.Constant,
  -- a floating point constant: 2.3e10
  Float = canonical_links.Constant,

  -- if, then, else, endif, switch, etc.
  Conditional = canonical_links.Statement,
  -- for, do, while, etc.
  Repeat = canonical_links.Statement,

  ------------------------------------------------------------------------------
  -- UI Highlight Groups                           see: :help 'highlight-groups'
  ------------------------------------------------------------------------------
}

local function reverse_map(tbl)
  -- Lua tables use reference equality:
  -- v == v is true. So, v can be used as a key in reversed
  local reversed = {}
  for k, v in pairs(tbl) do
    if type(v) == "table" and next(v) ~= nil then
      reversed[v] = k
    end
  end
  return reversed
end

local function lookup_keys(lookup_table, tbl)
  local result = {}
  for k, v in pairs(tbl) do
    local foreign_key = lookup_table[v]
    if foreign_key then
      result[k] = foreign_key
    end
  end
  return result
end

-- Initialize an empty colorscheme
vim.cmd("highlight clear")
vim.cmd("syntax reset")
vim.g.colors_name = "spf"

-- Apply highlights
for k, v in pairs(spf_highlights) do
  if type(v) == "table" and next(v) ~= nil then
    vim.api.nvim_set_hl(0, k, v)
  end
end

-- Apply links
local highlight_keys = reverse_map(spf_highlights)
for k, v in pairs(lookup_keys(highlight_keys, canonical_links)) do
  if type(v) == "string" then
    vim.api.nvim_set_hl(0, k, { link = v })
  end
end

-- Apply link links
local link_keys = reverse_map(canonical_links)
for k, v in pairs(lookup_keys(link_keys, derived_links)) do
  if type(v) == "string" then
    vim.api.nvim_set_hl(0, k, { link = v })
  end
end
