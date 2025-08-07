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
  cursorline = "#1f1d1b",

  red_dark = "#33201f",
  red = "#bd7671",
  red_bright = "#ffa099",

  orange_dark = "#a1633f",
  orange = "#ce9178",
  orange_bright = "#f29950",

  yellow_dark = "#33331f",
  yellow = "#c2c27c",
  yellow_bright = "#fcfca4",

  chartreuse_dark = "#758e57",
  chartreuse = "#91b76b",
  chartreuse_bright = "#cfeaa0",

  green_dark = "#1f3326",
  green = "#8fa899",
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

  blue_dark = "#142233",
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

  gold = "#a38e5d",
}

local spf_highlights = {

  -- UI
  bold = { bold = true, fg = "fg", bg = "fg" },
  underline = { bold = true, fg = "", bg = "" },

  foreground_on_background = { fg = colors.foreground, bg = colors.background },
  foreground_on_primary_accent_background = {
    fg = colors.ui_tertiary_background,
    bg = colors.background,
  },

  tertiary_accent_background_on_secondary_accent_background = {
    fg = colors.ui_tertiary_background,
    bg = colors.ui_secondary_background,
  },

  background_on_background = { fg = "bg" },

  CursorLine = { fg = "", bg = "#1f1d1b" },

  -- Color Palette
  red = { fg = colors.red, bg = "" },
  red_bright = { fg = colors.red_bright, bg = "" },
  -- red_dark
  red_on_nothing_underline = { fg = colors.red, bg = "", underline = true },

  orange = { fg = colors.orange, bg = "" },
  -- orange_bright
  -- orange_dark

  yellow = { fg = colors.yellow, bg = "" },
  -- yellow_bright
  -- yellow_dark
  yellow_on_nothing_underline = { undercurl = true, fg = colors.yellow, bg = "" },

  green = { fg = colors.green, bg = "" },
  green_bright = { fg = colors.green_bright, bg = "" },
  -- green_dark
  green_on_nothing_underline = { undercurl = true, fg = colors.green, bg = "" },

  cyan = { fg = colors.cyan, bg = "" },
  cyan_bright = { fg = colors.cyan_bright, bg = "" },
  -- cyan_dark

  blue = { fg = colors.blue, bg = "" },
  blue_bright = { fg = colors.blue_bright, bg = "" },
  -- blue_dark
  blue_on_nothing_underline = { undercurl = true, fg = colors.blue, bg = "" },

  azure = { fg = colors.azure, bg = "" },
  -- azure_bright
  -- azure_dark

  magenta = { fg = colors.magenta, bg = "" },
  magenta_bright = { fg = colors.magenta_bright, bg = "" },
  -- magenta_dark
  magenta_on_nothing_underline = { undercurl = true, fg = colors.magenta, bg = "" },

  -- white
  white_dark = { fg = colors.white_dark, bg = "" },
  white_bright = { fg = colors.white_bright, bg = "" },

  -- black
  black = { fg = colors.black, bg = "" },
  black_bright = { fg = colors.black_bright, bg = "" },
  black_bright_on_dark_red = { fg = colors.black_bright, bg = colors.red_dark },
  black_bright_on_primary_accent_background = {
    fg = colors.black_bright,
    bg = colors.ui_primary_background,
  },
  black_dark = { fg = colors.black_dark, bg = "" },
  black_bright_italic = { italic = true, fg = colors.black_bright, bg = "" },
  black_bright_strikethrough = { strikethrough = true, fg = colors.black_bright, bg = "" },
  black_on_primary_accent_background = { fg = colors.black_bright, bg = colors.ui_primary_background },

  nothing_on_dark_yellow = { fg = "", bg = colors.yellow_dark },
  nothing_on_dark_green = { fg = "", bg = colors.green_dark },
  nothing_on_dark_blue = { fg = "", bg = colors.magenta_dark },
  nothing_on_black_dark = { fg = "", bg = colors.black_dark },

  secondary_accent_on_nothing = { fg = colors.ui_secondary_background, bg = "" },

  gold = { fg = colors.gold, bg = "" },
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
  -- case, default, etc.
  Labal = spf_highlights.cyan,
  -- "sizeof", "+", "*", etc.
  Operator = spf_highlights.white_dark,
  -- any erroneous construct
  Error = spf_highlights.red,
  -- int, long, char, etc.
  Type = spf_highlights.green,
  -- static, register, volatile, etc.
  StorageClass = spf_highlights.red_bright,
  -- struct, union, enum, etc.
  Structure = spf_highlights.green_bright,
  -- generic Preprocessor
  PreProc = spf_highlights.blue_bright,
  -- any special symbol
  Special = spf_highlights.gold,

  -- added line in a diff
  Added = spf_highlights.green,
  -- changed line in a diff
  Changed = spf_highlights.yellow,
  -- removed line in a diff
  Removed = spf_highlights.red,

  -- text that stands out, HTML links
  Underlined = spf_highlights.underline,
  -- character that needs attention
  Delimiter = spf_highlights.white_bright,

  -- you can use CTRL-] on this
  Tag = spf_highlights.azure,
  -- debugging statements
  Debug = spf_highlights.magenta,

  -- left blank, hidden  |hl-Ignore|
  Ignore = spf_highlights.background_on_background,

  ------------------------------------------------------------------------------
  -- UI Highlight Groups                           see: :help 'highlight-groups'
  ------------------------------------------------------------------------------

  -- Normal text.
  Normal = spf_highlights.foreground_on_background,

  -- hl-Search
  -- Last search pattern highlighting (see 'hlsearch').
  -- Also used for similar items that need to stand out.
  Search = spf_highlights.white_dark,

  -- hl-NormalFloat
  -- Normal text in floating windows.
  NormalFloat = spf_highlights.foreground_on_background,

  -- hl-Title
  -- Titles for output from ":set all", ":autocmd" etc.
  Title = spf_highlights.bold,

  -- hl-FloatBorder
  -- Border of floating windows.
  FloatBorder = spf_highlights.black_bright,

  -- hl-FloatTitle
  -- Title of floating windows.
  FloatTitle = spf_highlights.foreground_on_background,

  -- hl-FloatFooter
  -- Footer of floating windows.
  FloatFooter = spf_highlights.foreground_on_background,

  -- hl-TabLine
  -- Tab pages line, not active tab page label.
  Tabline = spf_highlights.tertiary_accent_background_on_secondary_accent_background,

  -- hl-TabLineFill
  -- Tab pages line, where there are no labels.
  TabLineFill = spf_highlights.tertiary_accent_background_on_secondary_accent_background,

  -- hl-TabLineSel
  -- Tab pages line, active tab page label.
  TabLineSel = spf_highlights.foreground_on_primary_accent_background,

  -- hl-DiffAdd
  -- Diff mode: Added line. |diff.txt|
  DiffAdd = spf_highlights.nothing_on_dark_green,

  -- hl-DiffChange
  -- Diff mode: Changed line. |diff.txt|
  DiffChange = spf_highlights.nothing_on_dark_yellow,

  -- hl-DiffDelete
  -- Diff mode: Deleted line. |diff.txt|
  DiffDelete = spf_highlights.black_bright_on_dark_red,

  -- hl-DiffText
  -- Diff mode: Changed text within a changed line. |diff.txt|
  DiffText = spf_highlights.nothing_on_dark_blue,

  -- hl-EndOfBuffer
  -- Filler lines (~) after the end of the buffer.
  -- By default, this is highlighted like |hl-NonText|.
  EndOfBUffer = spf_highlights.background_on_background,

  -- hl-WinSeparator
  -- Separators between window splits.
  WinSeparator = spf_highlights.secondary_accent_on_nothing,

  Folded = spf_highlights.black_on_primary_accent_background,

  -- hl-FoldColumn
  -- 'foldcolumn'
  ["FoldColumn"] = {},

  -- hl-ColorColumn
  -- Used for the columns set with 'colorcolumn'.
  ["ColorColumn"] = {},

  -- hl-Cursor
  -- Character under the cursor.
  ["Cursor"] = {},

  -- hl-lCursor
  -- Character under the cursor when |language-mapping|
  -- is used (see 'guicursor').
  ["lCursor"] = {},

  -- hl-CursorIM
  -- Like Cursor, but used when in IME mode. *CursorIM*
  ["CursorIM"] = {},

  -- hl-CursorColumn
  -- Screen-column at the cursor, when 'cursorcolumn' is set.
  ["CursorColumn"] = {},

  -- hl-CursorLineNr
  -- Like LineNr when 'cursorline' is set and 'cursorlineopt'
  -- contains "number" or is "both", for the cursor line.
  ["CursorLineNr"] = {},

  -- hl-CursorLineFold
  -- Like FoldColumn when 'cursorline' is set for the cursor line.
  ["CursorLineFold"] = {},

  -- hl-CursorLineSign
  -- Like SignColumn when 'cursorline' is set for the cursor line.
  ["CursorLineSign"] = {},

  -- hl-TermCursor
  -- Cursor in a focused terminal.
  ["TermCursor"] = {},

  -- hl-Pmenu
  -- Popup menu: Normal item.
  ["Pmenu"] = {},

  -- hl-PmenuSel
  -- Popup menu: Selected item. Combined with |hl-Pmenu|.
  ["PmenuSel"] = {},

  -- hl-PmenuKind
  -- Popup menu: Normal item "kind".
  ["PmenuKind"] = {},

  -- hl-PmenuKindSel
  -- Popup menu: Selected item "kind".
  ["PmenuKindSel"] = {},

  -- hl-PmenuExtra
  -- Popup menu: Normal item "extra text".
  ["PmenuExtra"] = {},

  -- hl-PmenuExtraSel
  -- Popup menu: Selected item "extra text".
  ["PmenuExtraSel"] = {},

  -- hl-PmenuSbar
  -- Popup menu: Scrollbar.
  ["PmenuSbar"] = {},

  -- hl-PmenuThumb
  -- Popup menu: Thumb of the scrollbar.
  ["PmenuThumb"] = {},

  -- hl-PmenuMatch
  -- Popup menu: Matched text in normal item. Combined with
  -- |hl-Pmenu|.
  ["PmenuMatch"] = {},

  -- hl-PmenuMatchSel
  -- Popup menu: Matched text in selected item. Combined with
  -- |hl-PmenuMatch| and |hl-PmenuSel|.
  ["PmenuMatchSel"] = {},

  -- hl-LineNr
  -- Line number for ":number" and ":#" commands, and when 'number'
  -- or 'relativenumber' option is set.
  ["LineNr"] = {},

  -- hl-LineNrAbove
  -- Line number for when the 'relativenumber'
  -- option is set, above the cursor line.
  ["LineNrAbove"] = {},

  -- hl-LineNrBelow
  -- Line number for when the 'relativenumber'
  -- option is set, below the cursor line.
  ["LineNrBelow"] = {},

  -- hl-ErrorMsg
  -- Error messages on the command line.
  ["ErrorMsg"] = {},

  -- hl-ModeMsg
  -- 'showmode' message (e.g., "-- INSERT --").
  ["ModeMsg"] = {},

  -- hl-MsgArea
  -- Area for messages and command-line, see also 'cmdheight'.
  ["MsgArea"] = {},

  -- hl-MsgSeparator
  -- Separator for scrolled messages |msgsep|.
  ["MsgSeparator"] = {},

  -- hl-Question
  -- |hit-enter| prompt and yes/no questions.
  ["Question"] = {},

  -- hl-MoreMsg
  -- |more-prompt|
  ["MoreMsg"] = {},

  -- hl-WarningMsg
  -- Warning messages.
  ["WarningMsg"] = {},

  -- hl-SpellBad
  -- Word that is not recognized by the spellchecker. |spell|
  -- Combined with the highlighting used otherwise.
  ["SpellBad"] = {},

  -- hl-SpellCap
  -- Word that should start with a capital. |spell|
  -- Combined with the highlighting used otherwise.
  ["SpellCap"] = {},

  -- hl-SpellLocal
  -- Word that is recognized by the spellchecker as one that is
  -- used in another region. |spell|
  -- Combined with the highlighting used otherwise.
  ["SpellLocal"] = {},

  -- hl-SpellRare
  -- Word that is recognized by the spellchecker as one that is
  -- hardly ever used. |spell|
  -- Combined with the highlighting used otherwise.
  ["SpellRare"] = {},

  -- hl-StatusLine
  -- Status line of current window.
  ["StatusLine"] = {},

  -- hl-StatusLineNC
  -- Status lines of not-current windows.
  ["StatusLineNC"] = {},

  -- hl-StatusLineTerm
  -- Status line of |terminal| window.
  ["StatusLineTerm"] = {},

  -- *hl-StatusLineTermNC
  -- Status line of non-current |terminal| windows.
  ["StatusLineTermNC"] = {},

  -- hl-QuickFixLine
  -- Current |quickfix| item in the quickfix window. Combined with
  -- |hl-CursorLine| when the cursor is there.
  ["QuickFixLine"] = {},

  -- hl-WinSeparator
  -- Separators between window splits.
  -- ["WinSeparator"] = { fg = colors.ui_primary_background, bg = colors.background },

  -- hl-SignColumn
  -- Column where |signs| are displayed.
  ["SignColumn"] = {},

  -- hl-WildMenu
  -- Current match in 'wildmenu' completion.
  ["WildMenu"] = {},

  -- hl-WinBar
  -- Window bar of current window.
  ["WinBar"] = {},

  -- hl-WinBarNC
  -- Window bar of not-current windows.
  ["WinBarNC"] = {},

  -- hl-ComplMatchIns
  -- Matched text of the currently inserted completion.
  ["ComplMatchIns"] = {},

  -- hl-SnippetTabstop
  -- Tabstops in snippets. |vim.snippet|
  ["SnippetTabstop"] = {},

  -- hl-Conceal
  -- Placeholder characters substituted for concealed
  ["Conceal"] = {},

  -- hl-Directory
  -- Directory names (and other special names in listings).
  ["Directory"] = {},

  -- hl-Substitute
  -- |:substitute| replacement text highlighting.
  ["Substitute"] = {},

  -- hl-MatchParen
  -- Character under the cursor or just before it, if it
  -- is a paired bracket, and its match. |pi_paren.txt|
  ["MatchParen"] = {},

  -- hl-NonText
  -- '@' at the end of the window, characters from 'showbreak'
  -- and other characters that do not really exist in the text
  -- (e.g., ">" displayed when a double-wide character doesn't
  -- fit at the end of the line). See also |hl-EndOfBuffer|.
  -- '@' at the end of the window, characters from 'showbreak'
  ["NonText"] = {},

  -- hl-Normal
  -- Normal text.
  -- ["Normal"] = { fg = colors.foreground, bg = colors.background },

  -- hl-NormalNC
  -- Normal text in non-current windows.
  ["NormalNC"] = {},

  -- hl-SpecialKey
  -- Unprintable characters: Text displayed differently from what
  -- it really is. But not 'listchars' whitespace. |hl-Whitespace|
  ["SpecialKey"] = {},

  -- hl-Visual
  -- Visual mode selection.
  ["Visual"] = {},

  -- hl-VisualNOS
  -- Visual mode selection when vim is "Not Owning the Selection".
  ["VisualNOS"] = {},

  -- hl-Whitespace
  -- "nbsp", "space", "tab", "multispace", "lead" and "trail"
  -- in 'listchars'.
  ["Whitespace"] = {},

  ------------------------------------------------------------------------------
  -- Diagnostic Highlights
  ------------------------------------------------------------------------------

  -- hl-DiagnosticError
  -- Used as the base highlight group.
  -- Other Diagnostic highlights link to this by default (except Underline)
  DiagnosticError = spf_highlights.red,

  -- hl-DiagnosticWarn
  -- Used as the base highlight group.
  -- Other Diagnostic highlights link to this by default (except Underline)
  DiagnosticWarn = spf_highlights.yellow,

  -- hl-DiagnosticInfo
  -- Used as the base highlight group.
  -- Other Diagnostic highlights link to this by default (except Underline)
  DiagnosticInfo = spf_highlights.blue,

  -- hl-DiagnosticHint
  -- Used as the base highlight group.
  -- Other Diagnostic highlights link to this by default (except Underline)
  DiagnosticHint = spf_highlights.magenta,

  -- hl-DiagnosticOk
  -- Used as the base highlight group.
  -- Other Diagnostic highlights link to this by default (except Underline)
  DiagnosticOk = spf_highlights.green,

  -- hl-DiagnosticUnderlineError
  -- Used to underline "Error" diagnostics.
  DiagnosticUnderlineError = spf_highlights.red_on_nothing_underline,

  -- hl-DiagnosticUnderlineWarn
  -- Used to underline "Warn" diagnostics.
  DiagnosticUnderlineWarn = spf_highlights.yellow_on_nothing_underline,

  -- hl-DiagnosticUnderlineInfo
  -- Used to underline "Info" diagnostics.
  DiagnosticUnderlineInfo = spf_highlights.blue_on_nothing_underline,

  -- hl-DiagnosticUnderlineHint
  -- Used to underline "Hint" diagnostics.
  DiagnosticUnderlineHint = spf_highlights.magenta_on_nothing_underline,

  -- hl-DiagnosticUnderlineOk
  -- Used to underline "Ok" diagnostics.
  DiagnosticUnderlineOk = spf_highlights.green_on_nothing_underline,

  -- hl-DiagnosticDeprecated
  -- Used for deprecated or obsolete code.
  DiagnosticDeprecated = spf_highlights.black_bright_strikethrough,

  -- hl-DiagnosticUnnecessary
  -- Used for unnecessary or unused code.
  DiagnosticUnnecessary = spf_highlights.black_bright_italic,

  ------------------------------------------------------------------------------
  -- LSP Highlights see:                                   :help 'lsp-highlight'
  ------------------------------------------------------------------------------

  -- used for highlighting "text" references
  LspReferenceText = spf_highlights.nothing_on_black_dark,

  -- used for highlighting "read" references
  LspReferenceRead = spf_highlights.nothing_on_dark_green,

  -- used for highlighting "write" references
  LspReferenceWrite = spf_highlights.nothing_on_dark_yellow,

  -- used for highlighting reference targets (e.g. in a hover range)
  LspReferenceTarget = spf_highlights.bold,

  -- used for highlighting inlay hints
  LspInlayHint = spf_highlights.black_bright,
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

  -- try, catch, throw
  Exception = canonical_links.Error,

  -- a typedef
  -- keywords TODO FIXME and XXX
  Todo = canonical_links.Keyword,
  Typedef = canonical_links.Keyword,

  -- preprocessor #include
  Include = canonical_links.PreProc,
  -- preprocessor #define
  Define = canonical_links.PreProc,
  -- same as Define
  Macro = canonical_links.PreProc,
  -- preprocessor #if, #else, #endif, etc.
  PreCondit = canonical_links.PreProc,
  -- special character in a constant

  SpecialChar = canonical_links.Special,
  -- special things inside a comment
  SpecialComment = canonical_links.Special,

  ------------------------------------------------------------------------------
  -- UI Highlight Groups                           see: :help 'highlight-groups'
  ------------------------------------------------------------------------------

  -- hl-CurSearch
  -- Current match for the last search pattern (see 'hlsearch').
  --    Note: This is correct after a search, but may get outdated if
  --    changes are made or the screen is redrawn.
  CurSearch = canonical_links.Search,

  -- hl-IncSearch
  -- 'incsearch' highlighting; also used for the text replaced with
  -- ":s///c".
  IncSearch = canonical_links.Search,

  ------------------------------------------------------------------------------
  -- Diagnostic Highlights
  ------------------------------------------------------------------------------

  -- hl-DiagnosticVirtualTextError
  -- Used for "Error" diagnostic virtual text.
  DiagnosticVirtualTextError = canonical_links.DiagnosticError,

  -- hl-DiagnosticVirtualTextWarn
  -- Used for "Warn" diagnostic virtual text.
  DiagnosticVirtualTextWarn = canonical_links.DiagnosticWarn,

  -- hl-DiagnosticVirtualTextInfo
  -- Used for "Info" diagnostic virtual text.
  DiagnosticVirtualTextInfo = canonical_links.DiagnosticInfo,

  -- hl-DiagnosticVirtualTextHint
  -- Used for "Hint" diagnostic virtual text.
  DiagnosticVirtualTextHint = canonical_links.DiagnosticHint,

  -- hl-DiagnosticVirtualTextOk
  -- Used for "Ok" diagnostic virtual text.
  DiagnosticVirtualTextOk = canonical_links.DiagnosticOk,

  -- hl-DiagnosticVirtualLinesError
  -- Used for "Error" diagnostic virtual lines.
  DiagnosticVirtualLinesError = canonical_links.DiagnosticError,

  -- hl-DiagnosticVirtualLinesWarn
  -- Used for "Warn" diagnostic virtual lines.
  DiagnosticVirtualLinesWarn = canonical_links.DiagnosticWarn,

  -- hl-DiagnosticVirtualLinesInfo
  -- Used for "Info" diagnostic virtual lines.
  DiagnosticVirtualLinesInfo = canonical_links.DiagnosticUnderlineInfo,

  -- hl-DiagnosticVirtualLinesHint
  -- Used for "Hint" diagnostic virtual lines.
  DiagnosticVirtualLinesHint = canonical_links.DiagnosticUnderlineHint,

  -- hl-DiagnosticVirtualLinesOk
  -- Used for "Ok" diagnostic virtual lines.
  DiagnosticVirtualLinesOk = canonical_links.DiagnosticUnderlineOk,

  -- See vim.diagnostic.open_float()
  DiagnosticFloatingError = canonical_links.DiagnosticError,

  -- hl-DiagnosticFloatingWarn
  -- Used to color "Warn" diagnostic messages in diagnostics float.
  DiagnosticFloatingWarn = canonical_links.DiagnosticWarn,

  -- hl-DiagnosticFloatingInfo
  -- Used to color "Info" diagnostic messages in diagnostics float.
  DiagnosticFloatingInfo = canonical_links.DiagnosticInfo,

  -- hl-DiagnosticFloatingHint
  -- Used to color "Hint" diagnostic messages in diagnostics float.
  DiagnosticFloatingHint = canonical_links.DiagnosticHint,

  -- hl-DiagnosticFloatingOk
  -- Used to color "Ok" diagnostic messages in diagnostics float.
  DiagnosticFloatingOk = canonical_links.DiagnosticOk,

  -- hl-DiagnosticSignError
  -- Used for "Error" signs in sign column.
  DiagnosticSignError = canonical_links.DiagnosticError,

  -- hl-DiagnosticSignWarn
  -- Used for "Warn" signs in sign column.
  DiagnosticSignWarn = canonical_links.DiagnosticWarn,

  -- hl-DiagnosticSignInfo
  -- Used for "Info" signs in sign column.
  DiagnosticSignInfo = canonical_links.DiagnosticInfo,

  -- hl-DiagnosticSignHint
  -- Used for "Hint" signs in sign column.
  DiagnosticSignHint = canonical_links.DiagnosticHint,

  -- hl-DiagnosticSignOk
  -- Used for "Ok" signs in sign column.
  DiagnosticSignOk = canonical_links.DiagnosticOk,

  ------------------------------------------------------------------------------
  -- LSP Semantic Highlights                       see: :help 'highlight-groups'
  ------------------------------------------------------------------------------

  -- Identifiers that declare or reference a class type
  ["@lsp.type.class"] = {},

  -- Tokens that represent a comment
  ["@lsp.type.comment"] = {},

  -- Identifiers that declare or reference decorators and annotations
  ["@lsp.type.decorator"] = {},

  -- Identifiers that declare or reference an enumeration type
  ["@lsp.type.enum"] = {},

  -- Identifiers that declare or reference an enumeration property, constant, or member
  ["@lsp.type.enumMember"] = {},

  -- Identifiers that declare an event property
  ["@lsp.type.event"] = {},

  -- Identifiers that declare a function
  ["@lsp.type.function"] = {},

  -- Identifiers that declare or reference an interface type
  ["@lsp.type.interface"] = {},

  -- Tokens that represent a language keyword
  ["@lsp.type.keyword"] = {},

  -- Identifiers that declare a macro
  ["@lsp.type.macro"] = {},

  -- Identifiers that declare a member function or method
  ["@lsp.type.method"] = {},

  -- Tokens that represent a modifier
  ["@lsp.type.modifier"] = {},

  -- Identifiers that declare or reference a namespace, module, or package
  ["@lsp.type.namespace"] = {},

  -- Tokens that represent a number literal
  ["@lsp.type.number"] = {},

  -- Tokens that represent an operator
  ["@lsp.type.operator"] = {},

  -- Identifiers that declare or reference a function or method parameters
  ["@lsp.type.parameter"] = {},

  -- Identifiers that declare or reference a member property, member field, or member variable
  ["@lsp.type.property"] = {},

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
  ["@variable"] = {},

  -- built-in variable names (e.g. `this`, `self`)
  ["@variable.builtin"] = {},

  -- parameters of a function
  ["@variable.parameter"] = {},

  -- special parameters (e.g. `_`, `it`)
  ["@variable.parameter.builtin"] = {},

  -- object and struct fields
  ["@variable.member"] = {},

  -- constant identifiers
  ["@constant"] = {},

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
  ["@property"] = {},

  -- function definitions
  ["@function"] = {},

  -- built-in functions
  ["@function.builtin"] = {},

  -- function calls
  ["@function.call"] = {},

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
  ["@keyword.function"] = {},

  -- operators that are English words (e.g. `and`, `or`)
  ["@keyword.operator"] = {},

  -- keywords for including or exporting modules (e.g. `import`, `from` in Python)
  ["@keyword.import"] = {},

  -- keywords describing namespaces and composite types (e.g. `struct`, `enum`)
  ["@keyword.type"] = {},

  -- keywords modifying other constructs (e.g. `const`, `static`, `public`)
  ["@keyword.modifier"] = {},

  -- keywords related to loops (e.g. `for`, `while`)
  ["@keyword.repeat"] = {},

  -- keywords like `return` and `yield`
  ["@keyword.return"] = {},

  -- keywords related to debugging
  ["@keyword.debug"] = {},

  -- keywords related to exceptions (e.g. `throw`, `catch`)
  ["@keyword.exception"] = {},

  -- keywords related to conditionals (e.g. `if`, `else`)
  ["@keyword.conditional"] = {},

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
  ["@markup.quote"] = {},

  -- math environments (e.g. `$ ... $` in LaTeX)
  ["@markup.math"] = {},

  -- text references, footnotes, citations, etc.
  ["@markup.link"] = {},

  -- link, reference descriptions
  ["@markup.link.label"] = {},

  -- URL-style links
  ["@markup.link.url"] = {},

  -- literal or verbatim text (e.g. inline code)
  ["@markup.raw"] = {},

  -- literal or verbatim text as a stand-alone block
  ["@markup.raw.block"] = {},

  -- list markers
  ["@markup.list"] = {},

  -- checked todo-style list markers
  ["@markup.list.checked"] = {},

  -- unchecked todo-style list markers
  ["@markup.list.unchecked"] = {},

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
  DiffAdded = canonical_links.Added,
  DiffChanged = canonical_links.Changed,
  DiffRemoved = canonical_links.Removed,

  -- markdown
  MarkdownHeading1 = canonical_links.Title,
  MarkdownHeading2 = canonical_links.Special,
  MarkdownHeading3 = canonical_links.Special,
  MarkdownHeading4 = canonical_links.Special,
  MarkdownHeading5 = canonical_links.Special,
  MarkdownHeading6 = canonical_links.Special,
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
