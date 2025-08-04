-------------------------------------------------------------------------------
-- SPF
--
-- This file is part of the SPF color scheme for Neovim.
-------------------------------------------------------------------------------

local colors = {
  foreground = "#ebdbb2",
  background = "#191816",
  cursor_line = "#1f1d1b",

  red_dark = "#b25f57",
  red = "#bd7671",
  red_bright = "#e7a3a4",

  orange_dark = "#a1633f",
  orange = "#d28445",
  orange_bright = "#f2b27b",

  yellow_dark = "#b9b237",
  yellow = "#e5dc6c",
  yellow_bright = "#f6f0a4",

  chartreuse_dark = "#758e57",
  chartreuse = "#91b76b",
  chartreuse_bright = "#cfeaa0",

  green_dark = "#4b6550",
  green = "#709d81",
  green_bright = "#b0d4b2",

  spring_dark = "#4f766e",
  spring = "#6da89e",
  spring_bright = "#a9d5c8",

  cyan_dark = "#536a71",
  cyan = "#6c97a7",
  cyan_bright = "#94bfc8",

  azure_dark = "#45667e",
  azure = "#5f87a6",
  azure_bright = "#a2c5e4",

  blue_dark = "#3f6999",
  blue = "#5692db",
  blue_bright = "#7aaadd",

  violet_dark = "#59497c",
  violet = "#8c70b6",
  violet_bright = "#c5afe4",

  magenta_dark = "#5f4469",
  magenta = "#a474b0",
  magenta_bright = "#d6a3e0",

  rose_dark = "#94586b",
  rose = "#c97e95",
  rose_bright = "#e8a9bb",

  black_dark = "#121210",
  black = "#3c3c3c",
  black_bright = "#666666",

  white_dark = "#a89f91",
  white = "#ebdbb2",
  white_bright = "#fff2d1",

  ui_primary_foreground = "#a6977c",
  ui_primary_background = "#2c2826",
  ui_secondary_background = "#504945",
  ui_tertiary_background = "#a89984",
}

local highlights = {

  builtins = {

    -- |group-name|
    group_names = {

      -- any comment
      -- Comment = { fg = colors.black_bright, bg = "bg", italic = true },

      -- any constant
      -- Constant = { fg = colors.cyan_bright, bg = "bg" },

      -- a string constant: "this is a string"
      -- String = { fg = colors.orange, bg = "" },
      -- a character constant: 'c', '\n'
      -- Character = { link = "Constant" },
      -- a number constant: 234, 0xff
      -- Number = { link = "Constant" },
      -- a boolean constant: TRUE, false
      -- Boolean = { link = "Constant" },
      -- a floating point constant: 2.3e10
      -- Float = { link = "Constant" },

      -- any variable name
      Identifier = { link = "Normal" },
      -- function name (also: methods for classes)
      Function = { fg = colors.yellow, bg = "bg" },
      -- any statement (flow control, return, etc.)
      Statement = { fg = colors.magenta_bright, bg = "bg" },
      -- if, then, else, endif, switch, etc.
      Conditional = { link = "Statement" },
      -- for, do, while, etc.
      Repeat = { link = "Statement" },
      -- case, default, etc.
      Label = { fg = colors.cyan, bg = "bg" },
      -- "sizeof", "+", "*", etc.
      Operator = { fg = colors.white },
      -- any other keyword
      Keyword = { fg = colors.blue, bg = "bg" },
      -- try, catch, throw
      Exception = { fg = colors.red, bg = "bg" },
      -- generic Preprocessor

      PreProc = { fg = colors.blue_bright, bg = "bg" },
      -- preprocessor #include
      Include = { link = "PreProc" },
      -- preprocessor #define
      Define = { link = "PreProc" },
      -- same as Define
      Macro = { link = "PreProc" },
      -- preprocessor #if, #else, #endif, etc.
      PreCondit = { link = "PreProc" },

      -- int, long, char, etc.
      Type = { fg = colors.green, bg = "bg" },
      -- static, register, volatile, etc.
      StorageClass = { fg = colors.red_bright, bg = "bg" },
      -- struct, union, enum, etc.
      Structure = { fg = colors.green_bright, bg = "bg" },
      -- a typedef
      Typedef = { fg = colors.magenta, bg = "bg" },

      -- any special symbol
      Special = { fg = colors.yellow_dark, bg = "bg" },
      -- special character in a constant
      SpecialChar = { link = "Special" },
      -- you can use CTRL-] on this
      SpecialComment = { link = "Special" },
      -- debugging statements
      Tag = { fg = colors.violet_bright, bg = "bg" },
      -- character that needs attention
      Delimiter = { fg = colors.foreground, bg = "bg" },
      -- special things inside a comment
      Debug = { fg = colors.violet, bg = "bg" },

      -- text that stands out, HTML links
      Underlined = { fg = "fg", bg = "bg", underline = true },

      -- left blank, hidden  |hl-Ignore|
      Ignore = { fg = "fg", bg = "bg" },

      -- any erroneous construct
      Error = { fg = colors.red, bg = "bg" },

      -- anything that needs extra attention; mostly the
      -- keywords TODO FIXME and XXX
      Todo = { fg = colors.blue, bg = "bg" },

      -- added line in a diff
      Added = { fg = colors.green, bg = "bg" },
      -- changed line in a diff
      Changed = { fg = colors.yellow, bg = "bg" },
      -- removed line in a diff
      Removed = { fg = colors.red, bg = "bg" },
    },

    -- |highlight-groups| |highlight-default|
    highlight_groups = {

      folds = {
        -- |hl-Folded|
        -- Line used for closed folds.
        ["Folded"] = { fg = colors.black_bright, bg = colors.black_dark, italic = true },

        -- hl-FoldColumn
        -- 'foldcolumn'
        ["FoldColumn"] = {},
      },

      search = {

        -- hl-CurSearch
        -- Current match for the last search pattern (see 'hlsearch').
        --    Note: This is correct after a search, but may get outdated if
        --    changes are made or the screen is redrawn.
        ["CurSearch"] = { link = "Search" },

        -- hl-IncSearch
        -- 'incsearch' highlighting; also used for the text replaced with
        -- ":s///c".
        ["IncSearch"] = { link = "Search" },

        -- hl-Search
        -- Last search pattern highlighting (see 'hlsearch').
        -- Also used for similar items that need to stand out.
        ["Search"] = { fg = "", bg = colors.black_bright },
      },

      cursor = {

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

        -- hl-CursorLine
        -- Screen-line at the cursor, when 'cursorline' is set.
        -- Low-priority if foreground (ctermfg OR guifg) is not set.
        ["CursorLine"] = { fg = "", bg = colors.cursor_line },

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
      },

      pmenu = {

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
      },

      line_number = {

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
      },

      message = {

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
      },

      floats = {

        -- hl-NormalFloat
        -- Normal text in floating windows.
        ["NormalFloat"] = { fg = colors.foreground, bg = colors.background },

        -- hl-FloatBorder
        -- Border of floating windows.
        ["FloatBorder"] = { fg = colors.black_bright, bg = colors.background },

        -- hl-FloatTitle
        -- Title of floating windows.
        ["FloatTitle"] = { fg = colors.black_bright, bg = colors.background, bold = true },

        -- hl-FloatFooter
        -- Footer of floating windows.
        ["FloatFooter"] = { fg = colors.black, bg = colors.background },
      },

      -- |diff|
      diff = {

        -- hl-DiffAdd
        -- Diff mode: Added line. |diff.txt|
        ["DiffAdd"] = { fg = "", bg = colors.green_dark },

        -- hl-DiffChange
        -- Diff mode: Changed line. |diff.txt|
        ["DiffChange"] = { fg = "", bg = colors.yellow_dark },

        -- hl-DiffDelete
        -- Diff mode: Deleted line. |diff.txt|
        ["DiffDelete"] = { fg = "", bg = colors.red_dark },

        -- hl-DiffText
        -- Diff mode: Changed text within a changed line. |diff.txt|
        ["DiffText"] = { fg = "", bg = colors.blue_dark },
      },

      spell = {

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
      },

      statusline = {

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
      },

      tabs = {

        -- hl-TabLine
        -- Tab pages line, not active tab page label.
        ["Tabline"] = { fg = colors.ui_primary_foreground, bg = colors.ui_secondary_background },

        -- hl-TabLineFill
        -- Tab pages line, where there are no labels.
        ["TabLineFill"] = { fg = colors.red, bg = colors.ui_primary_background },

        -- hl-TabLineSel
        -- Tab pages line, active tab page label.
        ["TabLineSel"] = { fg = colors.background, bg = colors.ui_tertiary_background },
      },

      ui = {

        -- hl-EndOfBuffer
        -- Filler lines (~) after the end of the buffer.
        -- By default, this is highlighted like |hl-NonText|.
        ["EndOfBUffer"] = { fg = colors.background, bg = colors.background },

        -- hl-QuickFixLine
        -- Current |quickfix| item in the quickfix window. Combined with
        -- |hl-CursorLine| when the cursor is there.
        ["QuickFixLine"] = {},

        -- hl-WinSeparator
        -- Separators between window splits.
        ["WinSeparator"] = { fg = colors.ui_primary_background, bg = colors.background },

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
      },

      completion = {

        -- hl-ComplMatchIns
        -- Matched text of the currently inserted completion.
        ["ComplMatchIns"] = {},

        -- hl-SnippetTabstop
        -- Tabstops in snippets. |vim.snippet|
        ["SnippetTabstop"] = {},
      },

      text = {

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

        -- hl-Title
        -- Titles for output from ":set all", ":autocmd" etc.
        ["Title"] = {},

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
      },
    },

    -- |diagnostic-highlights|
    diagnostic_highlights = {

      -- hl-DiagnosticError
      -- Used as the base highlight group.
      -- Other Diagnostic highlights link to this by default (except Underline)
      ["DiagnosticError"] = { fg = colors.red, bg = "bg" },

      -- hl-DiagnosticWarn
      -- Used as the base highlight group.
      -- Other Diagnostic highlights link to this by default (except Underline)
      ["DiagnosticWarn"] = { fg = colors.yellow, bg = "bg" },

      -- hl-DiagnosticInfo
      -- Used as the base highlight group.
      -- Other Diagnostic highlights link to this by default (except Underline)
      ["DiagnosticInfo"] = { fg = colors.blue, bg = "bg" },

      -- hl-DiagnosticHint
      -- Used as the base highlight group.
      -- Other Diagnostic highlights link to this by default (except Underline)
      ["DiagnosticHint"] = { fg = colors.cyan, bg = "bg" },

      -- hl-DiagnosticOk
      -- Used as the base highlight group.
      -- Other Diagnostic highlights link to this by default (except Underline)
      ["DiagnosticOk"] = { fg = colors.green, bg = "bg" },

      -- hl-DiagnosticVirtualTextError
      -- Used for "Error" diagnostic virtual text.
      ["DiagnosticVirtualTextError"] = { fg = colors.red, bg = "bg" },

      -- hl-DiagnosticVirtualTextWarn
      -- Used for "Warn" diagnostic virtual text.
      ["DiagnosticVirtualTextWarn"] = { fg = colors.yellow, bg = "bg" },

      -- hl-DiagnosticVirtualTextInfo
      -- Used for "Info" diagnostic virtual text.
      ["DiagnosticVirtualTextInfo"] = { fg = colors.blue, bg = "bg" },

      -- hl-DiagnosticVirtualTextHint
      -- Used for "Hint" diagnostic virtual text.
      ["DiagnosticVirtualTextHint"] = { fg = colors.cyan, bg = "bg" },

      -- hl-DiagnosticVirtualTextOk
      -- Used for "Ok" diagnostic virtual text.
      ["DiagnosticVirtualTextOk"] = { fg = colors.green, bg = "bg" },

      -- hl-DiagnosticVirtualLinesError
      -- Used for "Error" diagnostic virtual lines.
      ["DiagnosticVirtualLinesError"] = { fg = colors.red, bg = "bg" },

      -- hl-DiagnosticVirtualLinesWarn
      -- Used for "Warn" diagnostic virtual lines.
      ["DiagnosticVirtualLinesWarn"] = { fg = colors.yellow, bg = "bg" },

      -- hl-DiagnosticVirtualLinesInfo
      -- Used for "Info" diagnostic virtual lines.
      ["DiagnosticVirtualLinesInfo"] = { fg = colors.blue, bg = "bg" },

      -- hl-DiagnosticVirtualLinesHint
      -- Used for "Hint" diagnostic virtual lines.
      ["DiagnosticVirtualLinesHint"] = { fg = colors.cyan, bg = "bg" },

      -- hl-DiagnosticVirtualLinesOk
      -- Used for "Ok" diagnostic virtual lines.
      ["DiagnosticVirtualLinesOk"] = { fg = colors.green, bg = "bg" },

      -- hl-DiagnosticUnderlineError
      -- Used to underline "Error" diagnostics.
      ["DiagnosticUnderlineError"] = { undercurl = true, sp = colors.red, fg = "fg", bg = "bg" },

      -- hl-DiagnosticUnderlineWarn
      -- Used to underline "Warn" diagnostics.
      ["DiagnosticUnderlineWarn"] = { undercurl = true, sp = colors.yellow, fg = "fg", bg = "bg" },

      -- hl-DiagnosticUnderlineInfo
      -- Used to underline "Info" diagnostics.
      ["DiagnosticUnderlineInfo"] = { undercurl = true, sp = colors.blue, fg = "fg", bg = "bg" },

      -- hl-DiagnosticUnderlineHint
      -- Used to underline "Hint" diagnostics.
      ["DiagnosticUnderlineHint"] = { undercurl = true, sp = colors.cyan, fg = "fg", bg = "bg" },

      -- hl-DiagnosticUnderlineOk
      -- Used to underline "Ok" diagnostics.
      ["DiagnosticUnderlineOk"] = { undercurl = true, sp = colors.green, fg = "fg", bg = "bg" },
      --
      -- hl-DiagnosticFloatingError
      -- Used to color "Error" diagnostic messages in diagnostics float.
      -- See vim.diagnostic.open_float()
      ["DiagnosticFloatingError"] = { fg = colors.red, bg = "bg" },

      -- hl-DiagnosticFloatingWarn
      -- Used to color "Warn" diagnostic messages in diagnostics float.
      ["DiagnosticFloatingWarn"] = { fg = colors.yellow, bg = "bg" },

      -- hl-DiagnosticFloatingInfo
      -- Used to color "Info" diagnostic messages in diagnostics float.
      ["DiagnosticFloatingInfo"] = { fg = colors.blue, bg = "bg" },

      -- hl-DiagnosticFloatingHint
      -- Used to color "Hint" diagnostic messages in diagnostics float.
      ["DiagnosticFloatingHint"] = { fg = colors.cyan, bg = "bg" },

      -- hl-DiagnosticFloatingOk
      -- Used to color "Ok" diagnostic messages in diagnostics float.
      ["DiagnosticFloatingOk"] = { fg = colors.green, bg = "bg" },

      -- hl-DiagnosticSignError
      -- Used for "Error" signs in sign column.
      ["DiagnosticSignError"] = { fg = colors.red, bg = "bg" },

      -- hl-DiagnosticSignWarn
      -- Used for "Warn" signs in sign column.
      ["DiagnosticSignWarn"] = { fg = colors.yellow, bg = "bg" },

      -- hl-DiagnosticSignInfo
      -- Used for "Info" signs in sign column.
      ["DiagnosticSignInfo"] = { fg = colors.blue, bg = "bg" },

      -- hl-DiagnosticSignHint
      -- Used for "Hint" signs in sign column.
      ["DiagnosticSignHint"] = { fg = colors.cyan, bg = "bg" },

      -- hl-DiagnosticSignOk
      -- Used for "Ok" signs in sign column.
      ["DiagnosticSignOk"] = { fg = colors.green, bg = "bg" },

      -- hl-DiagnosticDeprecated
      -- Used for deprecated or obsolete code.
      ["DiagnosticDeprecated"] = { strikethrough = true, fg = colors.black_bright, bg = "bg" },

      -- hl-DiagnosticUnnecessary
      -- Used for unnecessary or unused code.
      ["DiagnosticUnnecessary"] = { italic = true, fg = colors.black_bright, bg = "bg" },
    },

    -- |lsp-highlight|
    lsp_highlights = {

      -- used for highlighting "text" references
      ["LspReferenceText"] = { fg = "", bg = colors.black_dark },

      -- used for highlighting "read" references
      ["LspReferenceRead"] = { fg = "", bg = colors.green_dark },

      -- used for highlighting "write" references
      ["LspReferenceWrite"] = { fg = "", bg = colors.yellow_dark },

      -- used for highlighting reference targets (e.g. in a hover range)
      ["LspReferenceTarget"] = { bold = true, fg = "fg", bg = "bg" },

      -- used for highlighting inlay hints
      ["LspInlayHint"] = { fg = colors.black_bright, bg = "bg" },
    },

    -- |lsp-semantic-highlight|
    lsp_semantic_highlights = {

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
    },
  },

  common = {

    git = {
      -- Some plugins use these instead of the standard |group-name|s
      ["DiffAdded"] = { link = "Added" },
      ["DiffChanged"] = { link = "Changed" },
      ["DiffRemoved"] = { link = "Removed" },
    },
  },

  file_types = {

    markdown = {
      vim.api.nvim_set_hl(0, "MarkdownHeading1", { link = "Title" }),
      vim.api.nvim_set_hl(0, "MarkdownHeading2", { link = "Special" }),
      vim.api.nvim_set_hl(0, "MarkdownHeading4", { link = "Special" }),
      vim.api.nvim_set_hl(0, "MarkdownHeading4", { link = "Special" }),
      vim.api.nvim_set_hl(0, "MarkdownHeading5", { link = "Special" }),
      vim.api.nvim_set_hl(0, "MarkdownHeading6", { link = "Special" }),
    },
  },
}

for k, v in pairs(colors) do
  if v then
    vim.api.nvim_set_hl(0, k, { fg = v, bg = "bg" })
  else
    vim.api.nvim_set_hl(0, k, { fg = "fg", bg = "bg" })
  end
end

local function apply_highlights(table)
  -- colors
  -- highlight groups
  for name, value in pairs(table) do
    if value.fg or value.link then
      vim.api.nvim_set_hl(0, name, value)
    elseif type(value) == "table" then
      apply_highlights(value)
    end
  end
end

vim.api.nvim_command("highlight clear")
vim.api.nvim_command("syntax reset")
vim.g.colors_name = "spf"

apply_highlights(highlights)
