-------------------------------------------------------------------------------
-- SPF
--
-- A colorscheme for Neovim
--
-- TODO: implement `g:terminal_color_*` (see: https://tinyurl.com/y78ntvjk)
--
-- TODO: Conceal highlight
-- see: :help highlight

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
  cursorline = "#1f1d1b",

  red = "#bd7671",
  bright_red = "#ffa099",
  dark_red = "#33201f",

  orange = "#ce9178",
  bright_orange = "#f29950",
  dark_orange = "#a1633f",

  yellow = "#c2c27c",
  bright_yellow = "#fcfca4",
  dark_yellow = "#33331f",

  chartreuse = "#91b76b",
  bright_chartreuse = "#cfeaa0",
  dark_chartreuse = "#758e57",

  green = "#8fa899",
  bright_green = "#b9d9b8",
  dark_green = "#1f3326",

  spring = "#6da89e",
  bright_spring = "#a9d5c8",
  dark_spring = "#4f766e",

  cyan = "#7b919e",
  bright_cyan = "#a7cacc",
  dark_cyan = "#536a71",

  azure = "#5f87a6",
  bright_azure = "#a2c5e4",
  dark_azure = "#45667e",

  blue = "#5692db",
  bright_blue = "#77b3fc",
  dark_blue = "#142233",

  violet = "#8a7b9e",
  bright_violet = "#eebaff",
  dark_violet = "#59497c",

  magenta = "#8f7099",
  bright_magenta = "#c99fd6",
  dark_magenta = "#5f4469",

  rose = "#c08081",
  bright_rose = "#e084a3",
  dark_rose = "#94586b",

  black = "#0e0d0c",
  bright_black = "#737373",
  dark_black = "#121210",

  white = "#ebdbb2",
  bright_white = "#f2e8ce",
  dark_white = "#a89f91",

  primary_accent_fg = "#a89984",
  primary_accent_bg = "#2c2826",

  secondary_accent_fg = "#a89984",
  secondary_accent_bg = "#504945",

  tertiary_accent_fg = "#2c2826",
  tertiary_accent_bg = "#a89984",

  gray_20 = "#333333",
  gold = "#a38e5d",
}

local highlights = {

  -- UI
  bold = { bold = true },
  underline = { underline = true },
  italic = { italic = true },

  foreground = { fg = colors.foreground, bg = "" },
  foreground_on_background = { fg = colors.foreground, bg = colors.background },
  foreground_on_bright_black_bold = {
    bold = true,
    fg = colors.foreground,
    bg = colors.bright_black,
  },
  foreground_on_primary_accent_bg = {
    fg = colors.tertiary_accent_bg,
    bg = colors.background,
  },

  background_on_background = { fg = colors.background, bg = colors.background },

  -- Red
  red = { fg = colors.red, bg = "" },
  bright_red = { fg = colors.bright_red, bg = "" },
  red_underline = { fg = colors.red, bg = "", underline = true },

  -- Orange
  orange = { fg = colors.orange, bg = "" },

  -- Yellow
  yellow = { fg = colors.yellow, bg = "" },
  yellow_undercurl = { undercurl = true, fg = colors.yellow, bg = "" },

  -- Green
  green = { fg = colors.green, bg = "" },
  bright_green = { fg = colors.bright_green, bg = "" },
  green_undercurl = { undercurl = true, fg = colors.green, bg = "" },

  -- Cyan
  cyan = { fg = colors.cyan, bg = "" },
  bright_cyan_italic = { italic = true, fg = colors.bright_cyan, bg = "" },

  -- Blue
  blue = { fg = colors.blue, bg = "" },
  bright_blue = { fg = colors.bright_blue, bg = "" },
  blue_undercurl = { undercurl = true, fg = colors.blue, bg = "" },

  -- Azure
  azure = { fg = colors.azure, bg = "" },

  -- Majenta
  magenta = { fg = colors.magenta, bg = "" },
  bright_magenta = { fg = colors.bright_magenta, bg = "" },
  magenta_undercurl = { undercurl = true, fg = colors.magenta, bg = "" },

  -- White
  bright_white = { fg = colors.bright_white, bg = "" },
  dark_white = { fg = colors.dark_white, bg = "" },

  -- Black
  bright_black = { fg = colors.bright_black, bg = "" },
  bright_black_on_dark_red = { fg = colors.bright_black, bg = colors.dark_red },
  bright_black_on_primary_accent_bg = {
    fg = colors.bright_black,
    bg = colors.primary_accent_bg,
  },
  bright_black_bold = { bold = true, fg = colors.bright_black, bg = "" },
  bright_black_italic = { italic = true, fg = colors.bright_black, bg = "" },
  bright_black_strikethrough = { strikethrough = true, fg = colors.bright_black, bg = "" },

  -- Backgrounds
  nothing_on_dark_yellow = { fg = "", bg = colors.dark_yellow },
  nothing_on_dark_green = { fg = "", bg = colors.dark_green },
  nothing_on_dark_magenta = { fg = "", bg = colors.dark_magenta },

  secondary_accent_bg = { fg = colors.secondary_accent_bg, bg = "" },

  primary_accent_fg_on_primary_accent_bg = {
    fg = colors.primary_accent_fg,
    bg = colors.primary_accent_bg,
  },

  secondary_accent_fg_on_secondary_accent_bg = {
    fg = colors.secondary_accent_fg,
    bg = colors.secondary_accent_bg,
  },

  tertiary_accent_fg_on_tertiary_accent_bg = {
    fg = colors.tertiary_accent_fg,
    bg = colors.tertiary_accent_bg,
  },

  tertiary_accent_bg_on_secondary_accent_bg = {
    fg = colors.tertiary_accent_bg,
    bg = colors.secondary_accent_bg,
  },

  nothing_on_visual = { fg = "", bg = colors.gray_20 },
  nothing_on_cursorline = { fg = "", bg = colors.cursorline },
  background_on_green = { bold = true, fg = colors.background, bg = colors.green },

  gold = { fg = colors.gold, bg = "" },
}

local links = {

  ------------------------------------------------------------------------------
  -- Syntax Highlight Groups                             see: :help 'group-name'
  ------------------------------------------------------------------------------

  -- any comment
  Comment = highlights.bright_black_italic,

  -- any variable name
  Identifier = highlights.foreground,

  -- any constant
  Constant = highlights.bright_cyan_italic,
  -- a character constant: 'c', '\n'
  Character = "Constant",
  -- a number constant: 234, 0xff
  Number = "Constant",
  -- a boolean constant: TRUE, false
  Boolean = "Constant",
  -- a floating point constant: 2.3e10
  Float = "Constant",

  -- a string constant: "this is a string"
  String = highlights.orange,

  -- function name (also: methods for classes)
  Function = highlights.yellow,

  -- any statement (flow control, return, etc.)
  Statement = highlights.bright_magenta,
  -- if, then, else, endif, switch, etc.
  Conditional = "Statement",
  -- for, do, while, etc.
  Repeat = "Statement",

  -- any other keyword
  Keyword = highlights.blue,
  -- keywords TODO FIXME and XXX
  Todo = highlights.blue,
  -- a typedef
  Typedef = highlights.blue,

  -- case, default, etc.
  Labal = highlights.cyan,

  -- "sizeof", "+", "*", etc.
  Operator = highlights.dark_white,

  -- any erroneous construct
  Error = highlights.red,

  -- try, catch, throw
  Exception = "Error",

  -- int, long, char, etc.
  Type = highlights.green,

  -- static, register, volatile, etc.
  StorageClass = highlights.bright_red,

  -- struct, union, enum, etc.
  Structure = highlights.bright_green,

  -- generic Preprocessor
  PreProc = highlights.bright_blue,
  -- preprocessor #include
  Include = "PreProc",
  -- preprocessor #define
  Define = "PreProc",
  -- same as Define
  Macro = "PreProc",
  -- preprocessor #if, #else, #endif, etc.
  PreCondit = "PreProc",

  -- any special symbol
  Special = highlights.gold,
  -- special character in a constant
  SpecialChar = "Special",
  -- special things inside a comment
  SpecialComment = "Special",

  -- added line in a diff
  Added = highlights.green,
  -- changed line in a diff
  Changed = highlights.yellow,
  -- removed line in a diff
  Removed = highlights.red,

  -- text that stands out, HTML links
  Underlined = highlights.underline,

  -- character that needs attention
  Delimiter = highlights.bright_white,

  -- you can use CTRL-] on this
  Tag = highlights.azure,

  -- debugging statements
  Debug = highlights.magenta,

  -- left blank, hidden  |hl-Ignore|
  Ignore = highlights.background_on_background,

  ------------------------------------------------------------------------------
  -- UI Highlight Groups                           see: :help 'highlight-groups'
  ------------------------------------------------------------------------------

  -- Normal text.
  Normal = highlights.foreground_on_background,

  -- hl-Search
  -- Last search pattern highlighting (see 'hlsearch').
  -- Also used for similar items that need to stand out.
  Search = highlights.background_on_green,
  -- hl-CurSearch
  -- Current match for the last search pattern (see 'hlsearch').
  -- Note: This is correct after a search, but may get outdated if
  -- changes are made or the screen is redrawn.
  CurSearch = "Search",
  -- hl-IncSearch
  -- 'incsearch' highlighting; also used for the text replaced with
  -- ":s///c".
  IncSearch = "Search",

  -- hl-Title
  -- Titles for output from ":set all", ":autocmd" etc.
  Title = highlights.bold,

  -- hl-NormalFloat
  -- Normal text in floating windows.
  NormalFloat = "Normal",

  -- hl-FloatBorder
  -- Border of floating windows.
  FloatBorder = highlights.bright_black,

  -- hl-FloatTitle
  -- Title of floating windows.
  FloatTitle = "Normal",

  -- hl-FloatFooter
  -- Footer of floating windows.
  FloatFooter = "Normal",

  -- hl-TabLine
  -- Tab pages line, not active tab page label.
  Tabline = highlights.tertiary_accent_bg_on_secondary_accent_bg,

  -- hl-TabLineFill
  -- Tab pages line, where there are no labels.
  TabLineFill = highlights.tertiary_accent_bg_on_secondary_accent_bg,

  -- hl-TabLineSel
  -- Tab pages line, active tab page label.
  TabLineSel = highlights.foreground_on_primary_accent_bg,

  -- hl-DiffAdd
  -- Diff mode: Added line. |diff.txt|
  DiffAdd = highlights.nothing_on_dark_green,

  -- hl-DiffChange
  -- Diff mode: Changed line. |diff.txt|
  DiffChange = highlights.nothing_on_dark_yellow,

  -- hl-DiffDelete
  -- Diff mode: Deleted line. |diff.txt|
  DiffDelete = highlights.bright_black_on_dark_red,

  -- hl-DiffText
  -- Diff mode: Changed text within a changed line. |diff.txt|
  DiffText = highlights.nothing_on_dark_magenta,

  -- hl-EndOfBuffer
  -- Filler lines (~) after the end of the buffer.
  -- By default, this is highlighted like |hl-NonText|.
  EndOfBUffer = "Ignore",

  -- hl-WinSeparator
  -- Separators between window splits.
  WinSeparator = highlights.secondary_accent_bg,

  -- |hl-Folded|
  -- Line used for closed folds.
  Folded = highlights.bright_black_on_primary_accent_bg,

  -- hl-FoldColumn
  -- 'foldcolumn'
  FoldColumn = {},

  -- hl-ColorColumn
  -- Used for the columns set with 'colorcolumn'.
  ColorColumn = "CursorLine",

  -- hl-Cursor
  -- Character under the cursor.
  Cursor = {},

  -- hl-lCursor
  -- Character under the cursor when |language-mapping|
  -- is used (see 'guicursor').
  lCursor = {},

  -- hl-CursorIM
  -- Like Cursor, but used when in IME mode. *CursorIM*
  CursorIM = {},

  -- hl-CursorColumn
  -- Screen-column at the cursor, when 'cursorcolumn' is set.
  CursorColumn = "CursorLine",

  -- hl-CursorLine
  -- Screen-line at the cursor, when 'cursorline' is set.
  -- Low-priority if foreground (ctermfg OR guifg) is not set.
  CursorLine = highlights.nothing_on_cursorline,

  -- hl-CursorLineNr
  -- Like LineNr when 'cursorline' is set and 'cursorlineopt'
  -- contains "number" or is "both", for the cursor line.
  CursorLineNr = highlights.bright_black_bold,

  -- hl-CursorLineFold
  -- Like FoldColumn when 'cursorline' is set for the cursor line.
  CursorLineFold = {},

  -- hl-CursorLineSign
  -- Like SignColumn when 'cursorline' is set for the cursor line.
  CursorLineSign = {},

  -- hl-TermCursor
  -- Cursor in a focused terminal.
  TermCursor = {},

  -- hl-Pmenu
  -- Popup menu: Normal item.
  Pmenu = highlights.foreground,

  -- hl-PmenuSel
  -- Popup menu: Selected item. Combined with |hl-Pmenu|.
  PmenuSel = highlights.nothing_on_visual,

  -- hl-PmenuSbar
  -- Popup menu: Scrollbar.
  PmenuSbar = "PmenuSel",

  -- hl-PmenuThumb
  -- Popup menu: Thumb of the scrollbar.
  PmenuThumb = "PmenuSel",

  -- hl-PmenuMatch
  -- Popup menu: Matched text in normal item. Combined with
  -- |hl-Pmenu|.
  PmenuMatch = {},

  -- hl-PmenuMatchSel
  -- Popup menu: Matched text in selected item. Combined with
  -- |hl-PmenuMatch| and |hl-PmenuSel|.
  PmenuMatchSel = {},

  -- hl-PmenuKind
  -- Popup menu: Normal item "kind".
  PmenuKind = {},

  -- hl-PmenuKindSel
  -- Popup menu: Selected item "kind".
  PmenuKindSel = {},

  -- hl-PmenuExtra
  -- Popup menu: Normal item "extra text".
  PmenuExtra = {},

  -- hl-PmenuExtraSel
  -- Popup menu: Selected item "extra text".
  PmenuExtraSel = {},

  -- hl-LineNr
  -- Line number for ":number" and ":#" commands, and when 'number'
  -- or 'relativenumber' option is set.
  LineNr = highlights.bright_black,

  -- hl-LineNrAbove
  -- Line number for when the 'relativenumber'
  -- option is set, above the cursor line.
  LineNrAbove = {},

  -- hl-LineNrBelow
  -- Line number for when the 'relativenumber'
  -- option is set, below the cursor line.
  LineNrBelow = {},

  -- hl-ErrorMsg
  -- Error messages on the command line.
  ErrorMsg = {},

  -- hl-ModeMsg
  -- 'showmode' message (e.g., "-- INSERT --").
  ModeMsg = {},

  -- hl-MsgArea
  -- Area for messages and command-line, see also 'cmdheight'.
  MsgArea = {},

  -- hl-MsgSeparator
  -- Separator for scrolled messages |msgsep|.
  MsgSeparator = {},

  -- hl-Question
  -- |hit-enter| prompt and yes/no questions.
  Question = {},

  -- hl-MoreMsg
  -- |more-prompt|
  MoreMsg = {},

  -- hl-WarningMsg
  -- Warning messages.
  WarningMsg = {},

  -- hl-SpellBad
  -- Word that is not recognized by the spellchecker. |spell|
  -- Combined with the highlighting used otherwise.
  SpellBad = {},

  -- hl-SpellCap
  -- Word that should start with a capital. |spell|
  -- Combined with the highlighting used otherwise.
  SpellCap = {},

  -- hl-SpellLocal
  -- Word that is recognized by the spellchecker as one that is
  -- used in another region. |spell|
  -- Combined with the highlighting used otherwise.
  SpellLocal = {},

  -- hl-SpellRare
  -- Word that is recognized by the spellchecker as one that is
  -- hardly ever used. |spell|
  -- Combined with the highlighting used otherwise.
  SpellRare = {},

  -- hl-StatusLine
  -- Status line of current window.
  StatusLine = {},

  -- hl-StatusLineNC
  -- Status lines of not-current windows.
  StatusLineNC = {},

  -- hl-StatusLineTerm
  -- Status line of |terminal| window.
  StatusLineTerm = {},

  -- *hl-StatusLineTermNC
  -- Status line of non-current |terminal| windows.
  StatusLineTermNC = {},

  -- hl-QuickFixLine
  -- Current |quickfix| item in the quickfix window. Combined with
  -- |hl-CursorLine| when the cursor is there.
  QuickFixLine = {},

  -- hl-SignColumn
  -- Column where |signs| are displayed.
  SignColumn = highlights.foreground_on_background,

  -- hl-WildMenu
  -- Current match in 'wildmenu' completion.
  WildMenu = {},

  -- hl-WinBar
  -- Window bar of current window.
  WinBar = {},

  -- hl-WinBarNC
  -- Window bar of not-current windows.
  WinBarNC = {},

  -- hl-ComplMatchIns
  -- Matched text of the currently inserted completion.
  ComplMatchIns = {},

  -- hl-SnippetTabstop
  -- Tabstops in snippets. |vim.snippet|
  SnippetTabstop = {},

  -- hl-Conceal
  -- Placeholder characters substituted for concealed
  Conceal = highlights.bright_black,

  -- hl-Directory
  -- Directory names (and other special names in listings).
  Directory = highlights.blue,

  -- hl-Substitute
  -- |:substitute| replacement text highlighting.
  Substitute = {},

  -- hl-MatchParen
  -- Character under the cursor or just before it, if it
  -- is a paired bracket, and its match. |pi_paren.txt|
  MatchParen = highlights.foreground_on_bright_black_bold,

  -- hl-NonText
  -- '@' at the end of the window, characters from 'showbreak'
  -- and other characters that do not really exist in the text
  -- (e.g., ">" displayed when a double-wide character doesn't
  -- fit at the end of the line). See also |hl-EndOfBuffer|.
  NonText = highlights.bright_black,

  -- hl-Normal
  -- Normal text.
  -- ["Normal"] = { fg = colors.foreground, bg = colors.background },

  -- hl-NormalNC
  -- Normal text in non-current windows.
  NormalNC = {},

  -- hl-SpecialKey
  -- Unprintable characters: Text displayed differently from what
  -- it really is. But not 'listchars' whitespace. |hl-Whitespace|
  SpecialKey = {},

  -- hl-Visual
  -- Visual mode selection.
  Visual = highlights.nothing_on_visual,

  -- hl-VisualNOS
  -- Visual mode selection when vim is "Not Owning the Selection".
  VisualNOS = {},

  -- hl-Whitespace
  -- "nbsp", "space", "tab", "multispace", "lead" and "trail"
  -- in 'listchars'.
  Whitespace = {},

  ------------------------------------------------------------------------------
  -- Diagnostic Highlights
  ------------------------------------------------------------------------------

  -- hl-DiagnosticError
  -- Used as the base highlight group. Other Diagnostic highlights link to this
  -- by default (except Underline)
  DiagnosticError = highlights.red,
  -- hl-DiagnosticVirtualTextError
  -- Used for "Error" diagnostic virtual text.
  DiagnosticVirtualTextError = "DiagnosticError",
  -- hl-DiagnosticVirtualLinesError
  -- Used for "Error" diagnostic virtual lines.
  DiagnosticVirtualLinesError = "DiagnosticError",
  -- See vim.diagnostic.open_float()
  DiagnosticFloatingError = "DiagnosticError",
  -- hl-DiagnosticSignError
  -- Used for "Error" signs in sign column.
  DiagnosticSignError = "DiagnosticError",
  -- hl-DiagnosticUnderlineError
  -- Used to underline "Error" diagnostics.
  DiagnosticUnderlineError = highlights.red_underline,

  -- hl-DiagnosticWarn
  -- Used as the base highlight group.
  -- Other Diagnostic highlights link to this by default (except Underline)
  DiagnosticWarn = highlights.yellow,
  -- hl-DiagnosticVirtualTextWarn
  -- Used for "Warn" diagnostic virtual text.
  DiagnosticVirtualTextWarn = "DiagnosticWarn",
  -- hl-DiagnosticVirtualLinesWarn
  -- Used for "Warn" diagnostic virtual lines.
  DiagnosticVirtualLinesWarn = "DiagnosticWarn",
  -- hl-DiagnosticFloatingWarn
  -- Used to color "Warn" diagnostic messages in diagnostics float.
  DiagnosticFloatingWarn = "DiagnosticWarn",
  -- hl-DiagnosticSignWarn
  -- Used for "Warn" signs in sign column.
  DiagnosticSignWarn = "DiagnosticWarn",
  -- hl-DiagnosticUnderlineWarn
  -- Used to underline "Warn" diagnostics.
  DiagnosticUnderlineWarn = highlights.yellow_undercurl,

  -- hl-DiagnosticInfo
  -- Used as the base highlight group.
  -- Other Diagnostic highlights link to this by default (except Underline)
  DiagnosticInfo = highlights.blue,
  -- hl-DiagnosticVirtualTextInfo
  -- Used for "Info" diagnostic virtual text.
  DiagnosticVirtualTextInfo = "DiagnosticInfo",
  -- hl-DiagnosticVirtualLinesInfo
  -- Used for "Info" diagnostic virtual lines.
  DiagnosticVirtualLinesInfo = "DiagnosticInfo",
  -- hl-DiagnosticFloatingInfo
  -- Used to color "Info" diagnostic messages in diagnostics float.
  DiagnosticFloatingInfo = "DiagnosticInfo",
  -- hl-DiagnosticSignInfo
  -- Used for "Info" signs in sign column.
  DiagnosticSignInfo = "DiagnosticInfo",
  -- hl-DiagnosticUnderlineInfo
  -- Used to underline "Info" diagnostics.
  DiagnosticUnderlineInfo = highlights.blue_undercurl,

  -- hl-DiagnosticHint
  -- Used as the base highlight group.
  -- Other Diagnostic highlights link to this by default (except Underline)
  DiagnosticHint = highlights.magenta,
  -- hl-DiagnosticVirtualTextHint
  -- Used for "Hint" diagnostic virtual text.
  DiagnosticVirtualTextHint = "DiagnosticHint",
  -- hl-DiagnosticVirtualLinesHint
  -- Used for "Hint" diagnostic virtual lines.
  DiagnosticVirtualLinesHint = "DiagnosticHint",
  -- hl-DiagnosticFloatingHint
  -- Used to color "Hint" diagnostic messages in diagnostics float.
  DiagnosticFloatingHint = "DiagnosticHint",
  -- hl-DiagnosticSignHint
  -- Used for "Hint" signs in sign column.
  DiagnosticSignHint = "DiagnosticHint",
  -- hl-DiagnosticUnderlineHint
  -- Used to underline "Hint" diagnostics.
  DiagnosticUnderlineHint = highlights.magenta_undercurl,

  -- hl-DiagnosticOk
  -- Used as the base highlight group.
  -- Other Diagnostic highlights link to this by default (except Underline)
  DiagnosticOk = highlights.green,
  -- hl-DiagnosticVirtualTextOk
  -- Used for "Ok" diagnostic virtual text.
  DiagnosticVirtualTextOk = "DiagnosticOk",
  -- hl-DiagnosticVirtualLinesOk
  -- Used for "Ok" diagnostic virtual lines.
  DiagnosticVirtualLinesOk = "DiagnosticOk",
  -- hl-DiagnosticFloatingOk
  -- Used to color "Ok" diagnostic messages in diagnostics float.
  DiagnosticFloatingOk = "DiagnosticOk",
  -- hl-DiagnosticSignOk
  -- Used for "Ok" signs in sign column.
  DiagnosticSignOk = "DiagnosticOk",
  -- hl-DiagnosticUnderlineOk
  -- Used to underline "Ok" diagnostics.
  DiagnosticUnderlineOk = highlights.green_undercurl,

  -- hl-DiagnosticDeprecated
  -- Used for deprecated or obsolete code.
  DiagnosticDeprecated = highlights.bright_black_strikethrough,
  -- hl-DiagnosticUnnecessary
  -- Used for unnecessary or unused code.
  DiagnosticUnnecessary = highlights.bright_black,

  ------------------------------------------------------------------------------
  -- LSP Highlights see:                                   :help 'lsp-highlight'
  ------------------------------------------------------------------------------

  -- used for highlighting "text" references
  LspReferenceText = highlights.nothing_on_dark_yellow,
  -- used for highlighting "read" references
  LspReferenceRead = highlights.nothing_on_dark_green,
  -- used for highlighting "write" references
  LspReferenceWrite = highlights.nothing_on_dark_yellow,
  -- used for highlighting reference targets (e.g. in a hover range)
  LspReferenceTarget = highlights.bold,
  -- used for highlighting inlay hints
  LspInlayHint = highlights.bright_black,

  ------------------------------------------------------------------------------
  -- LSP Semantic Highlights                       see: :help 'highlight-groups'
  ------------------------------------------------------------------------------

  -- Identifiers that declare or reference a class type
  ["@lsp.type.class"] = {},
  -- Tokens that represent a comment
  ["@lsp.type.comment"] = "Comment",
  -- Identifiers that declare or reference decorators and annotations
  ["@lsp.type.decorator"] = {},
  -- Identifiers that declare or reference an enumeration type
  ["@lsp.type.enum"] = {},
  -- Identifiers that declare or reference an enumeration property, constant, or member
  ["@lsp.type.enumMember"] = {},
  -- Identifiers that declare an event property
  ["@lsp.type.event"] = {},
  -- Identifiers that declare a function
  ["@lsp.type.function"] = "Function",
  -- Identifiers that declare or reference an interface type
  ["@lsp.type.interface"] = {},
  -- Tokens that represent a language keyword
  ["@lsp.type.keyword"] = {},
  -- Identifiers that declare a macro
  ["@lsp.type.macro"] = {},
  -- Identifiers that declare a member function or method
  ["@lsp.type.method"] = "Function",
  -- Tokens that represent a modifier
  ["@lsp.type.modifier"] = {},
  -- Identifiers that declare or reference a namespace, module, or package
  ["@lsp.type.namespace"] = {},
  -- Tokens that represent a number literal
  ["@lsp.type.number"] = {},
  -- Tokens that represent an operator
  ["@lsp.type.operator"] = {},
  -- Identifiers that declare or reference a function or method parameters
  ["@lsp.type.parameter"] = highlights.italic,
  -- Identifiers that declare or reference a member property, member field, or member variable
  ["@lsp.type.property"] = highlights.green,
  -- Tokens that represent a regular expression literal
  ["@lsp.type.regexp"] = {},
  -- Tokens that represent a string literal
  ["@lsp.type.string"] = {},
  -- Identifiers that declare or reference a struct type
  ["@lsp.type.struct"] = {},
  -- Identifiers that declare or reference a type that is not covered above
  ["@lsp.type.type"] = {},
  -- Identifiers that declare or reference a type parameter
  ["@lsp.type.typeParameter"] = {},
  -- Identifiers that declare or reference a local or global variable
  ["@lsp.type.variable"] = {},
  -- Types and member functions that are abstract
  ["@lsp.mod.abstract"] = {},
  -- Functions that are marked async
  ["@lsp.mod.async"] = {},
  -- Declarations of symbols
  ["@lsp.mod.declaration"] = {},
  -- Symbols that are part of the standard library
  ["@lsp.mod.defaultLibrary"] = {},
  -- Definitions of symbols, for example, in header files
  ["@lsp.mod.definition"] = {},
  -- Symbols that should no longer be used
  ["@lsp.mod.deprecated"] = {},
  -- Occurrences of symbols in documentation
  ["@lsp.mod.documentation"] = {},
  -- Variable references where the variable is assigned to
  ["@lsp.mod.modification"] = {},
  -- Readonly variables and member fields (constants)
  ["@lsp.mod.readonly"] = {},
  -- Class members (static members)
  ["@lsp.mod.static"] = {},

  ------------------------------------------------------------------------------
  -- Treesitter Highlight Groups        see: :help 'treesitter-highlight-groups'
  ------------------------------------------------------------------------------

  -- various variable names
  ["@variable"] = highlights.foreground,
  -- built-in variable names (e.g. `this`, `self`)
  ["@variable.builtin"] = {},
  -- parameters of a function
  ["@variable.parameter"] = {},
  -- special parameters (e.g. `_`, `it`)
  ["@variable.parameter.builtin"] = {},
  -- object and struct fields
  ["@variable.member"] = {},
  -- constant identifiers
  ["@constant"] = "Constant",
  -- built-in constant values
  ["@constant.builtin"] = {},
  -- constants defined by the preprocessor
  ["@constant.macro"] = {},
  -- modules or namespaces
  ["@module"] = {},
  -- built-in modules or namespaces
  ["@module.builtin"] = {},
  -- `GOTO` and other labels (e.g. `label:` in C), including heredoc labels
  ["@label"] = {},
  -- string literals
  ["@string"] = {},
  -- string documenting code (e.g. Python docstrings)
  ["@string.documentation"] = {},
  -- regular expressions
  ["@string.regexp"] = {},
  -- escape sequences
  ["@string.escape"] = {},
  -- other special strings (e.g. dates)
  ["@string.special"] = {},
  -- symbols or atoms
  ["@string.special.symbol"] = {},
  -- filenames
  ["@string.special.path"] = {},
  -- URIs (e.g. hyperlinks)
  ["@string.special.url"] = {},
  -- character literals
  ["@character"] = {},
  -- special characters (e.g. wildcards)
  ["@character.special"] = {},
  -- boolean literals
  ["@boolean"] = {},
  -- numeric literals
  ["@number"] = {},
  -- floating-point number literals
  ["@number.float"] = {},
  -- type or class definitions and annotations
  ["@type"] = {},
  -- built-in types
  ["@type.builtin"] = {},
  -- identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)
  ["@type.definition"] = {},
  -- attribute annotations (e.g. Python decorators, Rust lifetimes)
  ["@attribute"] = {},
  -- builtin annotations (e.g. `@property` in Python)
  ["@attribute.builtin"] = {},
  -- the key in key/value pairs
  ["@property"] = highlights.green,
  -- function definitions
  ["@function"] = {},
  -- built-in functions
  ["@function.builtin"] = {},
  -- function calls
  ["@function.call"] = highlights.italic,
  -- preprocessor macros
  ["@function.macro"] = {},
  -- method definitions
  ["@function.method"] = {},
  -- method calls
  ["@function.method.call"] = {},
  -- constructor calls and definitions
  ["@constructor"] = {},
  -- symbolic operators (e.g. `+`, `*`)
  ["@operator"] = {},
  -- keywords not fitting into specific categories
  ["@keyword"] = {},
  -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
  ["@keyword.coroutine"] = {},
  -- keywords that define a function (e.g. `func` in Go, `def` in Python)
  ["@keyword.function"] = "Keyword",
  -- operators that are English words (e.g. `and`, `or`)
  ["@keyword.operator"] = highlights.red,
  -- keywords for including or exporting modules (e.g. `import`, `from` in Python)
  ["@keyword.import"] = {},
  -- keywords describing namespaces and composite types (e.g. `struct`, `enum`)
  ["@keyword.type"] = {},
  -- keywords modifying other constructs (e.g. `const`, `static`, `public`)
  ["@keyword.modifier"] = {},
  -- keywords related to loops (e.g. `for`, `while`)
  ["@keyword.repeat"] = highlights.bright_magenta,
  -- keywords like `return` and `yield`
  ["@keyword.return"] = {},
  -- keywords related to debugging
  ["@keyword.debug"] = {},
  -- keywords related to exceptions (e.g. `throw`, `catch`)
  ["@keyword.exception"] = {},
  -- keywords related to conditionals (e.g. `if`, `else`)
  ["@keyword.conditional"] = highlights.bright_magenta,
  -- ternary operator (e.g. `?`, `:`)
  ["@keyword.conditional.ternary"] = {},
  -- various preprocessor directives and shebangs
  ["@keyword.directive"] = {},
  -- preprocessor definition directives
  ["@keyword.directive.define"] = {},
  -- delimiters (e.g. `;`, `.`, `,`)
  ["@punctuation.delimiter"] = {},
  -- brackets (e.g. `()`, `{}`, `[]`)
  ["@punctuation.bracket"] = {},
  -- special symbols (e.g. `{}` in string interpolation)
  ["@punctuation.special"] = {},
  -- line and block comments
  ["@comment"] = {},
  -- comments documenting code
  ["@comment.documentation"] = {},
  -- error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
  ["@comment.error"] = {},
  -- warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
  ["@comment.warning"] = {},
  -- todo-type comments (e.g. `TODO`, `WIP`)
  ["@comment.todo"] = {},
  -- note-type comments (e.g. `NOTE`, `INFO`, `XXX`)
  ["@comment.note"] = {},
  -- bold text
  ["@markup.strong"] = {},
  -- italic text
  ["@markup.italic"] = {},
  -- struck-through text
  ["@markup.strikethrough"] = {},
  -- underlined text (only for literal underline markup!)
  ["@markup.underline"] = {},
  -- headings, titles (including markers)
  ["@markup.heading"] = {},
  -- top-level heading
  ["@markup.heading.1"] = {},
  -- section heading
  ["@markup.heading.2"] = {},
  -- subsection heading
  ["@markup.heading.3"] = {},
  -- and so on
  ["@markup.heading.4"] = {},
  -- and so forth
  ["@markup.heading.5"] = {},
  -- six levels ought to be enough for anybody
  ["@markup.heading.6"] = {},
  -- block quotes
  ["@markup.quote"] = highlights.italic,
  -- math environments (e.g. `$ ... $` in LaTeX)
  ["@markup.math"] = {},
  -- text references, footnotes, citations, etc.
  ["@markup.link"] = highlights.magenta,
  -- link, reference descriptions
  ["@markup.link.label"] = highlights.blue,
  -- URL-style links
  ["@markup.link.url"] = highlights.magenta,
  -- literal or verbatim text (e.g. inline code)
  ["@markup.raw"] = highlights.orange,
  -- literal or verbatim text as a stand-alone block
  ["@markup.raw.block"] = {},
  -- list markers
  ["@markup.list"] = {},
  -- checked todo-style list markers
  ["@markup.list.checked"] = highlights.green,
  -- unchecked todo-style list markers
  ["@markup.list.unchecked"] = highlights.red,
  -- added text (for diff files)
  ["@diff.plus"] = {},
  -- deleted text (for diff files)
  ["@diff.minus"] = {},
  -- changed text (for diff files)
  ["@diff.delta"] = {},
  -- XML-style tag names (e.g. in XML, HTML, etc.)
  ["@tag"] = {},
  -- builtin tag names (e.g. HTML5 tags)
  ["@tag.builtin"] = {},
  -- XML-style tag attributes
  ["@tag.attribute"] = {},
  -- XML-style tag delimiters
  ["@tag.delimiter"] = {},

  ------------------------------------------------------------------------------
  -- Other Common Highlights
  ------------------------------------------------------------------------------

  -- Some colorschemes and plugins use these (Normal)
  diffAdded = highlights.green,
  diffChanged = highlights.yellow,
  diffRemoved = highlights.red,
  diffFile = {},
  diffNewFile = {},
  diffLine = {},

  -- markdown
  markdownH1 = "Title",
  markdownH2 = highlights.gold,
  markdownH3 = "markdownH2",
  markdownH4 = "markdownH2",
  markdownH5 = "markdownH2",
  markdownH6 = "markdownH2",
  ["@markup.heading.1.markdown"] = "markdownH1",
  ["@markup.heading.2.markdown"] = "markdownH2",
  ["@markup.heading.3.markdown"] = "markdownH3",
  ["@markup.heading.4.markdown"] = "markdownH4",
  ["@markup.heading.5.markdown"] = "markdownH5",
  ["@markup.heading.6.markdown"] = "markdownH6",
  markdownCode = highlights.nothing_on_cursorline,
  markdownCodeBlock = highlights.red,
  markdownCodeDelimiter = {},
  markdownBlockquote = {},
  markdownListMarker = highlights.gold,
  markdownOrderedListMarker = {},
  markdownRule = {},
  markdownHeadingRule = {},
  markdownUrlDelimiter = {},
  markdownLinkDelimiter = {},
  markdownLinkTextDelimiter = {},
  markdownHeadingDelimiter = {},
  markdownUrl = {},
  markdownUrlTitleDelimiter = {},
  markdownLinkText = {},
  markdownIdDeclaration = {},

  -- Terraform
  ["@lsp.type.type.terraform"] = "Keyword",

  ------------------------------------------------------------------------------
  -- TODO: what are these?
  ["@method"] = highlights.yellow,
  ["@method.call"] = highlights.italic,
  ["@repeat"] = highlights.bright_magenta,
  ["@lsp.typemod.function"] = highlights.yellow,
  ["@conditional"] = highlights.bright_magenta,
  ["@text.literal.markdown_inline"] = highlights.yellow,
  -- Intentionally disabled:
  -- ["number"] = highlights.foreground_on_background,

  ------------------------------------------------------------------------------

  ------------------------------------------------------------------------------
  -- User Highlights
  ------------------------------------------------------------------------------

  -- TODO: Add Comment for User1, User2, User3
  User1 = highlights.primary_accent_fg_on_primary_accent_bg,
  User2 = highlights.secondary_accent_fg_on_secondary_accent_bg,
  User3 = highlights.tertiary_accent_fg_on_tertiary_accent_bg,
}

local function is_nonempty_table(x)
  return type(x) == "table" and next(x) ~= nil
end

local function is_nonempty_string(s)
  return type(s) == "string" and s ~= ""
end

---Check if a highlight group exists.
---@param name string The highlight group name
---@return boolean
local function hl_exists(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  local fmt = "Highlight group '%s' does not exist."
  vim.notify(string.format(fmt, name), vim.log.levels.DEBUG, { title = "SPF" })
  return ok and next(hl) ~= nil
end

--- Reverse-map non-empty table values to their keys.
--- Returns: ok:boolean, result:table
local function reverse_map(tbl)
  local reversed = {}
  for key, val in pairs(tbl) do
    if is_nonempty_table(val) then
      local existing = reversed[val]
      if existing ~= nil then
        local fmt = "Fix duplicate table value for keys %s and %s to load SPF."
        local msg = fmt:format(tostring(existing), tostring(key))
        vim.notify(msg, vim.log.levels.ERROR, { title = "SPF" })
        return false, {}
      end
      reversed[val] = key
    end
  end
  return true, reversed
end

local function resolve_link_name(spec, highlight_names)
  if is_nonempty_string(spec) then
    return spec
  elseif is_nonempty_table(spec) then
    return highlight_names[spec]
  end
  return nil
end

-- Bail out before applying highlights if the reverse map fails
local ok, highlight_keys = reverse_map(highlights)
if not ok then
  return
end

-- Initialize an empty colorscheme
vim.cmd([[
  highlight clear
  syntax reset
]])
vim.g.colors_name = "spf"

-- Apply concrete highlight specs
for group, spec in pairs(highlights) do
  if is_nonempty_table(spec) then
    vim.api.nvim_set_hl(0, group, spec)
  end
end

-- Apply links (link target is looked up via the reverse map)
for group, spec in pairs(links) do
  local target = resolve_link_name(spec, highlight_keys)
  if type(target) == "string" and target ~= "" then
    vim.api.nvim_set_hl(0, group, { link = target })
  end
end
