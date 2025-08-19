-------------------------------------------------------------------------------
-- SPF
--
-- A colorscheme for Neovim
--
-- TODO: implement `g:terminal_color_*` (see: https://tinyurl.com/y78ntvjk)
--
-- TODO: Conceal highlight
--
--------------------------------------------------------------------------------
-- :e $VIMRUNTIME/colors/README.txt
-- :e $VIMRUNTIME/doc/dev_theme.txt
-- :h highlight-groups                (Normal, Comment, etc.)
-- :h group-name                      (Keyword, Function, etc.)
-- :h diagnostic-highlights           (DiagnosticError, etc)
-- :h treesitter-highlight-groups     (@variable, @variable.builtin, etc)
-- :h lsp-semantic-highlight          (@lsp.type.variable.lua, etc)
-- :h lsp-highlight                   (LspReferenceRead, etc)
-------------------------------------------------------------------------------

-- TODO: remove this:
local colors = require("bw.config.new-colors")

local highlights = {

  bold = { bold = true },
  underline = { underline = true },
  italic = { italic = true },

  white = { fg = colors.white },
  other_white = { fg = colors.white },
  white_on_black = { fg = colors.white, bg = colors.black },
  white_on_bright_black_bold = { bold = true, fg = colors.white, bg = colors.bright_black },
  bright_white = { fg = colors.bright_white },

  black_on_black = { fg = colors.black, bg = colors.black },
  black_on_red = { fg = colors.black, bg = colors.red },
  black_on_yellow = { fg = colors.black, bg = colors.yellow },
  black_on_green = { fg = colors.black, bg = colors.green },
  black_on_blue = { fg = colors.black, bg = colors.blue },

  bright_black = { fg = colors.bright_black },
  bright_black_on_primary_accent_bg = {
    fg = colors.bright_black,
    bg = colors.primary_accent_bg,
  },
  bright_black_bold = { bold = true, fg = colors.bright_black },
  bright_black_strikethrough = { strikethrough = true, fg = colors.bright_black },

  red = { fg = colors.red },
  red_on_black = { fg = colors.red, bg = colors.black },
  red_underline = { fg = colors.red, underline = true },
  bright_red = { fg = colors.bright_red },

  orange = { fg = colors.orange },

  yellow = { fg = colors.yellow },
  yellow_on_black = { fg = colors.yellow, bg = colors.black },
  yellow_italic = { italic = true, fg = colors.yellow },
  yellow_undercurl = { undercurl = true, fg = colors.yellow },

  green = { fg = colors.green },
  green_on_black = { fg = colors.green, bg = colors.black },
  bright_green = { fg = colors.bright_green },
  green_undercurl = { undercurl = true, fg = colors.green },

  cyan = { fg = colors.cyan },
  bright_cyan = { fg = colors.bright_cyan },

  blue = { fg = colors.blue },
  blue_on_black = { fg = colors.blue, bg = colors.black },
  bright_blue = { fg = colors.bright_blue },
  blue_undercurl = { undercurl = true, fg = colors.blue },

  magenta = { fg = colors.magenta },
  magenta_on_black = { fg = colors.magenta, bg = colors.black },
  bright_magenta = { fg = colors.bright_magenta },
  magenta_undercurl = { undercurl = true, fg = colors.magenta },

  rose = { fg = colors.rose },

  nothing_on_black = { bg = colors.black },

  secondary_accent_bg = { fg = colors.secondary_accent_bg },

  primary_accent_fg_on_primary_accent_bg = {
    fg = colors.primary_accent_fg,
    bg = colors.primary_accent_bg,
  },

  secondary_accent_fg_on_secondary_accent_bg = {
    fg = colors.secondary_accent_fg,
    bg = colors.secondary_accent_bg,
  },

  nothing_on_visual = { bg = colors.gray_20 },
  nothing_on_cursorline = { bg = colors.cursorline },

  gold = { fg = colors.gold },
}

local links = {

  ------------------------------------------------------------------------------
  -- Syntax Highlight Groups                             see: :help 'group-name'
  ------------------------------------------------------------------------------

  -- any comment
  Comment = highlights.bright_black,

  -- any variable name
  Identifier = highlights.white,

  -- any constant
  Constant = highlights.bright_cyan,
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
  Statement = highlights.magenta,
  -- if, then, else, endif, switch, etc.
  Conditional = "Statement",
  -- for, do, while, etc.
  Repeat = "Statement",

  -- any other keyword
  Keyword = highlights.blue,
  -- keywords TODO FIXME and XXX
  Todo = highlights.blue,

  -- a typedef
  Typedef = highlights.rose,

  -- case, default, etc.
  Label = highlights.cyan,

  -- "sizeof", "+", "*", etc.
  Operator = highlights.white,

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
  Tag = highlights.blue,

  -- debugging statements
  Debug = highlights.magenta,

  -- left blank, hidden  |hl-Ignore|
  Ignore = highlights.black_on_black,

  ------------------------------------------------------------------------------
  -- UI Highlight Groups                           see: :help 'highlight-groups'
  ------------------------------------------------------------------------------

  -- Normal text.
  Normal = highlights.white_on_black,

  -- hl-Search
  -- Last search pattern highlighting (see 'hlsearch').
  -- Also used for similar items that need to stand out.
  Search = highlights.nothing_on_visual,
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
  Tabline = "WinBarNC",

  -- hl-TabLineFill
  -- Tab pages line, where there are no labels.
  TabLineFill = "WinBarNC",

  -- hl-TabLineSel
  -- Tab pages line, active tab page label.
  TabLineSel = "Normal",

  -- hl-DiffAdd
  -- Diff mode: Added line. |diff.txt|
  DiffAdd = highlights.black_on_green,

  -- hl-DiffChange
  -- Diff mode: Changed line. |diff.txt|
  DiffChange = highlights.black_on_yellow,

  -- hl-DiffDelete
  -- Diff mode: Deleted line. |diff.txt|
  DiffDelete = highlights.black_on_red,

  -- hl-DiffText
  -- Diff mode: Changed text within a changed line. |diff.txt|
  DiffText = highlights.black_on_blue,

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
  Pmenu = highlights.nothing_on_black,

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
  ErrorMsg = highlights.red,

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
  WarningMsg = highlights.yellow,

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
  SignColumn = "Normal",

  -- hl-WildMenu
  -- Current match in 'wildmenu' completion.
  WildMenu = {},

  -- hl-WinBar
  -- Window bar of current window.
  WinBar = highlights.primary_accent_fg_on_primary_accent_bg,

  -- hl-WinBarNC
  -- Window bar of not-current windows.
  WinBarNC = highlights.secondary_accent_fg_on_secondary_accent_bg,

  -- hl-ComplMatchIns
  -- Matched text of the currently inserted completion.
  ComplMatchIns = {},

  -- hl-SnippetTabstop
  -- Tabstops in snippets. |vim.snippet|
  SnippetTabstop = {},

  -- hl-Conceal
  -- Placeholder characters substituted for concealed
  Conceal = {},

  -- hl-Directory
  -- Directory names (and other special names in listings).
  Directory = highlights.blue,

  -- hl-Substitute
  -- |:substitute| replacement text highlighting.
  Substitute = {},

  -- hl-MatchParen
  -- Character under the cursor or just before it, if it
  -- is a paired bracket, and its match. |pi_paren.txt|
  MatchParen = highlights.white_on_bright_black_bold,

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
  DiagnosticError = highlights.red,
  -- hl-DiagnosticVirtualTextError
  DiagnosticVirtualTextError = highlights.red_on_black,
  -- hl-DiagnosticVirtualLinesError
  DiagnosticVirtualLinesError = "DiagnosticError",
  -- hl-DiagnosticFloatingError
  DiagnosticFloatingError = "DiagnosticError",
  -- hl-DiagnosticSignError
  DiagnosticSignError = "DiagnosticVirtualTextError",
  -- hl-DiagnosticUnderlineError
  DiagnosticUnderlineError = highlights.red_underline,

  -- hl-DiagnosticWarn
  DiagnosticWarn = highlights.yellow,
  -- hl-DiagnosticVirtualTextWarn
  DiagnosticVirtualTextWarn = highlights.yellow_on_black,
  -- hl-DiagnosticVirtualLinesWarn
  DiagnosticVirtualLinesWarn = "DiagnosticWarn",
  -- hl-DiagnosticFloatingWarn
  DiagnosticFloatingWarn = "DiagnosticWarn",
  -- hl-DiagnosticSignWarn
  DiagnosticSignWarn = "DiagnosticWarn",
  -- hl-DiagnosticUnderlineWarn
  DiagnosticUnderlineWarn = highlights.yellow_undercurl,

  -- hl-DiagnosticInfo
  DiagnosticInfo = highlights.blue,
  -- hl-DiagnosticVirtualTextInfo
  DiagnosticVirtualTextInfo = highlights.blue_on_black,
  -- hl-DiagnosticVirtualLinesInfo
  DiagnosticVirtualLinesInfo = "DiagnosticInfo",
  -- hl-DiagnosticFloatingInfo
  DiagnosticFloatingInfo = "DiagnosticInfo",
  -- hl-DiagnosticSignInfo
  DiagnosticSignInfo = "DiagnosticInfo",
  -- hl-DiagnosticUnderlineInfo
  DiagnosticUnderlineInfo = highlights.blue_undercurl,

  -- hl-DiagnosticHint
  DiagnosticHint = highlights.magenta,
  -- hl-DiagnosticVirtualTextHint
  DiagnosticVirtualTextHint = highlights.magenta_on_black,
  -- hl-DiagnosticVirtualLinesHint
  DiagnosticVirtualLinesHint = "DiagnosticHint",
  -- hl-DiagnosticFloatingHint
  DiagnosticFloatingHint = "DiagnosticHint",
  -- hl-DiagnosticSignHint
  DiagnosticSignHint = "DiagnosticHint",
  -- hl-DiagnosticUnderlineHint
  DiagnosticUnderlineHint = highlights.magenta_undercurl,

  -- hl-DiagnosticOk
  DiagnosticOk = highlights.green,
  -- hl-DiagnosticVirtualTextOk
  DiagnosticVirtualTextOk = highlights.magenta_on_black,
  -- hl-DiagnosticVirtualLinesOk
  DiagnosticVirtualLinesOk = "DiagnosticOk",
  -- hl-DiagnosticFloatingOk
  DiagnosticFloatingOk = "DiagnosticOk",
  -- hl-DiagnosticSignOk
  DiagnosticSignOk = "DiagnosticOk",
  -- hl-DiagnosticUnderlineOk
  DiagnosticUnderlineOk = highlights.green_undercurl,

  -- hl-DiagnosticDeprecated
  DiagnosticDeprecated = highlights.bright_black_strikethrough,
  -- hl-DiagnosticUnnecessary
  DiagnosticUnnecessary = highlights.bright_black,

  ------------------------------------------------------------------------------
  -- LSP Highlights see:                                   :help 'lsp-highlight'
  ------------------------------------------------------------------------------

  -- used for highlighting "text" references
  LspReferenceText = highlights.bold,
  -- used for highlighting "read" references
  LspReferenceRead = highlights.bold,
  -- used for highlighting "write" references
  LspReferenceWrite = highlights.bold,
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
  ["@variable"] = highlights.white,
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
  ["@function.call"] = highlights.yellow_italic,
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
  ["@keyword.repeat"] = highlights.magenta,
  -- keywords like `return` and `yield`
  ["@keyword.return"] = {},
  -- keywords related to debugging
  ["@keyword.debug"] = {},
  -- keywords related to exceptions (e.g. `throw`, `catch`)
  ["@keyword.exception"] = {},
  -- keywords related to conditionals (e.g. `if`, `else`)
  ["@keyword.conditional"] = highlights.magenta,
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
  markdownCodeBlock = "markdownCode",
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
  ["@repeat"] = highlights.magenta,
  ["@lsp.typemod.function"] = highlights.yellow,
  ["@conditional"] = highlights.magenta,
  ["@text.literal.markdown_inline"] = highlights.yellow,
  -- Intentionally disabled:
  -- ["number"] = highlights.foreground_on_background,

  ------------------------------------------------------------------------------
}

local function is_nonempty_table(x)
  return type(x) == "table" and next(x) ~= nil
end

local function is_nonempty_string(s)
  return type(s) == "string" and s ~= ""
end

--- Reverse-map non-empty table values to their keys.
--- Returns: result:table
local function reverse_map(tbl)
  local reversed = {}
  for key, val in pairs(tbl) do
    if is_nonempty_table(val) then
      reversed[val] = key
    end
  end
  return reversed
end

local function resolve_link_name(spec, highlight_names)
  if is_nonempty_string(spec) then
    return spec
  elseif is_nonempty_table(spec) then
    return highlight_names[spec]
  end
  return nil
end

local highlight_keys = reverse_map(highlights)

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
    vim.api.nvim_set_hl(0, group, { link = target, default = false })
  end
end
