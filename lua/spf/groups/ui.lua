-- UI highlight groups -> primitives.           see :help 'highlight-groups'
return {
  -- Normal text.
  Normal = "white_on_black",

  -- hl-Search
  -- Last search pattern highlighting (see 'hlsearch').
  -- Also used for similar items that need to stand out.
  Search = "nothing_on_visual",
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
  Title = "bold",

  -- hl-NormalFloat
  -- Normal text in floating windows.
  NormalFloat = "Normal",

  -- hl-FloatBorder
  -- Border of floating windows.
  FloatBorder = "bright_black",

  -- hl-FloatTitle
  -- Title of floating windows.
  FloatTitle = "Normal",

  -- hl-FloatFooter
  -- Footer of floating windows.
  FloatFooter = "Normal",

  -- hl-TabLine
  -- Tab pages line, not active tab page label.
  TabLine = "WinBarNC",

  -- hl-TabLineFill
  -- Tab pages line, where there are no labels.
  TabLineFill = "WinBarNC",

  -- hl-TabLineSel
  -- Tab pages line, active tab page label.
  TabLineSel = "Normal",

  -- hl-DiffAdd
  -- Diff mode: Added line. |diff.txt|
  DiffAdd = "nothing_on_dark_green",

  -- hl-DiffChange
  -- Diff mode: Changed line. |diff.txt|
  DiffChange = "nothing_on_dark_yellow",

  -- hl-DiffDelete
  -- Diff mode: Deleted line. |diff.txt|
  DiffDelete = "nothing_on_dark_red",

  -- hl-DiffText
  -- Diff mode: Changed text within a changed line. |diff.txt|
  DiffText = "nothing_on_dark_blue",

  -- hl-EndOfBuffer
  -- Filler lines (~) after the end of the buffer.
  -- By default, this is highlighted like |hl-NonText|.
  EndOfBuffer = "Ignore",

  -- hl-WinSeparator
  -- Separators between window splits.
  WinSeparator = "Comment",

  -- |hl-Folded|
  -- Line used for closed folds.
  Folded = "primary_accent",

  -- hl-FoldColumn
  -- 'foldcolumn'
  FoldColumn = {},

  -- hl-ColorColumn
  -- Used for the columns set with 'colorcolumn'.
  ColorColumn = "nothing_on_cursorline",

  -- hl-Cursor
  -- Character under the cursor.
  Cursor = "tertiary_accent",

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
  CursorLine = "nothing_on_cursorline",

  -- hl-CursorLineNr
  -- Like LineNr when 'cursorline' is set and 'cursorlineopt'
  -- contains "number" or is "both", for the cursor line.
  CursorLineNr = "bright_black_bold",

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
  Pmenu = "nothing_on_black",

  -- hl-PmenuSel
  -- Popup menu: Selected item. Combined with |hl-Pmenu|.
  PmenuSel = "nothing_on_visual",

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
  LineNr = "bright_black",

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
  ErrorMsg = "red",

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
  WarningMsg = "yellow",

  -- hl-SpellBad
  -- Word that is not recognized by the spellchecker. |spell|
  -- Combined with the highlighting used otherwise.
  SpellBad = "underline",

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
  StatusLine = "primary_accent",

  -- hl-StatusLineNC
  -- Status lines of not-current windows.
  StatusLineNC = "secondary_accent",

  -- hl-StatusLineTerm
  -- Status line of |terminal| window.
  StatusLineTerm = "tertiary_accent",

  -- *hl-StatusLineTermNC
  -- Status line of non-current |terminal| windows.
  StatusLineTermNC = {},

  -- hl-QuickFixLine
  -- Current |quickfix| item in the quickfix window. Combined with
  -- |hl-CursorLine| when the cursor is there.
  QuickFixLine = "bold",

  -- hl-SignColumn
  -- Column where |signs| are displayed.
  SignColumn = "Normal",

  -- hl-WildMenu
  -- Current match in 'wildmenu' completion.
  WildMenu = {},

  -- hl-WinBar
  -- Window bar of current window.
  WinBar = "primary_accent",

  -- hl-WinBarNC
  -- Window bar of not-current windows.
  WinBarNC = "secondary_accent",

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
  Directory = "blue",

  -- hl-Substitute
  -- |:substitute| replacement text highlighting.
  Substitute = {},

  -- hl-MatchParen
  -- Character under the cursor or just before it, if it
  -- is a paired bracket, and its match. |pi_paren.txt|
  MatchParen = "white_on_bright_black_bold",

  -- hl-NonText
  -- '@' at the end of the window, characters from 'showbreak'
  -- and other characters that do not really exist in the text
  -- (e.g., ">" displayed when a double-wide character doesn't
  -- fit at the end of the line). See also |hl-EndOfBuffer|.
  NonText = "bright_black",

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
  Visual = "nothing_on_visual",

  -- hl-VisualNOS
  -- Visual mode selection when vim is "Not Owning the Selection".
  VisualNOS = {},

  -- hl-Whitespace
  -- "nbsp", "space", "tab", "multispace", "lead" and "trail"
  -- in 'listchars'.
  Whitespace = {},
}
