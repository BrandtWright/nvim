-------------------------------------------------------------------------------
-- SPF
--
-- A colorscheme for Neovim
--
-- TODO: implement `g:terminal_color_*` (see: https://tinyurl.com/y78ntvjk)

-- see: :help 'highlight'
-- see: :edit $VIMRUNTIME/colors/README.txt
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

local highlights = {

  ------------------------------------------------------------------------------
  -- Syntax Highlight Groups
  -- see: :help 'group-name'
  ------------------------------------------------------------------------------

  cyan_bright = { fg = colors.cyan_bright, bg = "bg" },
  black_bright_italic = { fg = colors.black_bright, bg = "bg", italic = true },
  orange = { fg = colors.orange, bg = "" },
}

local links = {
  -- any comment
  Comment = highlights.black_bright_italic,
  -- any constant
  Constant = highlights.cyan_bright,
  -- a string constant: "this is a string"
  String = highlights.orange,
  -- a character constant: 'c', '\n'
  -- Character = { link = "Constant" },
}

local function map_links()
  -- Create a reverse lookup: keyset -> highlight name
  -- Note: each table is enumerated only once for constant-time lookups
  local reverse_highlights = {}
  for highlight_name, highlight_value in pairs(highlights) do
    -- Lua tables use reference equality:
    -- highlights.red == highlights.red is true
    -- So, the highlight_value table can be used as a key in reverse_highlights.
    if type(highlight_value) == "table" and next(highlight_value) ~= nil then
      reverse_highlights[highlight_value] = highlight_name
    end
  end

  local result = {}
  for link_name, highlight in pairs(links) do
    local highlight_name = reverse_highlights[highlight]
    if highlight_name then
      result[link_name] = highlight_name
    end
  end
  return result
end

-- Initialize an empty colorscheme
vim.cmd("highlight clear")
vim.cmd("syntax reset")
vim.g.colors_name = "spf"

-- Apply highlights
for k, v in pairs(highlights) do
  if type(v) == "table" and next(v) ~= nil then
    vim.api.nvim_set_hl(0, k, v)
  end
end

-- Apply links
for k, v in pairs(map_links()) do
  if type(v) == "string" then
    vim.api.nvim_set_hl(0, k, { link = v })
  end
end
