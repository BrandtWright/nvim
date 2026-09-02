-- UI highlight groups -> primitives.           see :help 'highlight-groups'
return {
  -- Normal text.
  Normal = "white_on_black",

  -- hl-Search
  -- Last search pattern highlighting (see 'hlsearch').
  -- Also used for similar items that need to stand out.
  Search = "black_on_yellow",
  -- hl-CurSearch
  -- Current match for the last search pattern (see 'hlsearch').
  -- Note: This is correct after a search, but may get outdated if
  -- changes are made or the screen is redrawn.
  CurSearch = "black_on_red",
  -- hl-IncSearch
  -- 'incsearch' highlighting; also used for the text replaced with
  -- ":s///c".
  IncSearch = "black_on_green",

  -- hl-Title
  -- Titles for output from ":set all", ":autocmd" etc.
  Title = "bold",

  -- hl-NormalFloat
  -- Normal text in floating windows. Content plane: a float is just a container,
  -- and the dominant floats here render *content* (picker previews, terminals)
  -- that must read as a buffer -- i.e. a `view`. A surface bg is reserved for
  -- `list` controls (Pmenu), which never hold content. The border delineates the
  -- float.
  NormalFloat = "Normal",

  -- hl-FloatBorder
  -- Border of floating windows. A quiet warm edge -- the depth cue for floats,
  -- since the surface itself is dark and close to content.
  FloatBorder = "border",

  -- hl-FloatTitle
  -- Title of floating windows. Sits on the float's content plane.
  FloatTitle = "NormalFloat",

  -- hl-FloatFooter
  -- Footer of floating windows. Sits on the float's content plane.
  FloatFooter = "NormalFloat",

  -- hl-TabLine
  -- Tab pages line, not active tab page label.
  TabLine = "WinBarNC",

  -- hl-TabLineFill
  -- Tab pages line, where there are no labels.
  TabLineFill = "WinBarNC",

  -- hl-TabLineSel
  -- Tab pages line, active tab page label. Active focus on the chrome surface
  -- (TabLine/TabLineFill follow WinBarNC = inactive focus).
  TabLineSel = "chrome_active",

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
  -- Line used for closed folds. A fold is collapsed *content*, not window
  -- furniture -- so it recedes (dim fg) rather than wearing a chrome surface.
  Folded = "recede",

  -- hl-FoldColumn
  -- 'foldcolumn'
  FoldColumn = {},

  -- hl-ColorColumn
  -- Used for the columns set with 'colorcolumn'. Shares the current-line lift.
  ColorColumn = "current_line",

  -- hl-Cursor
  -- Character under the cursor. Emphasis (strong): an inverted block.
  Cursor = "cursor_block",

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
  -- The current content line: a faint warm lift of Normal (its own concept,
  -- not the gray emphasis family) so it stays easy on the eyes.
  CursorLine = "current_line",

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
  -- Popup menu: Normal item. The completion menu is a `list` control (its
  -- selected item is PmenuSel -> selection).
  Pmenu = "list",

  -- hl-PmenuSel
  -- Popup menu: Selected item. Combined with |hl-Pmenu|. Emphasis: selection.
  PmenuSel = "selection",

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
  LineNr = "recede",

  -- hl-LineNrAbove
  -- Line number for when the 'relativenumber'
  -- option is set, above the cursor line.
  LineNrAbove = {},

  -- hl-LineNrBelow
  -- Line number for when the 'relativenumber'
  -- option is set, below the cursor line.
  LineNrBelow = {},

  -- hl-ErrorMsg
  -- Error messages on the command line. Follows the diagnostic error role so
  -- the "error" color lives in one place (same hue today; single-source recolor).
  ErrorMsg = "DiagnosticError",

  -- hl-ModeMsg
  -- 'showmode' message (e.g., "-- INSERT --"). A quiet, persistent indicator;
  -- recedes. (Was {} -> leaked Neovim's off-palette green.)
  ModeMsg = "recede",

  -- hl-MsgArea
  -- Area for messages and command-line, see also 'cmdheight'.
  MsgArea = {},

  -- hl-MsgSeparator
  -- Separator for scrolled messages |msgsep|.
  MsgSeparator = {},

  -- hl-Question
  -- |hit-enter| prompt and yes/no questions. Needs to be read -> content fg.
  -- (Was {} -> leaked Neovim's off-palette cyan.)
  Question = "white",

  -- hl-MoreMsg
  -- |more-prompt|. Transient prompt; recedes. (Was {} -> off-palette cyan.)
  MoreMsg = "recede",

  -- hl-WarningMsg
  -- Warning messages. Follows the diagnostic warn role (see ErrorMsg).
  WarningMsg = "DiagnosticWarn",

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
  -- Status line of current window. Chrome surface: raised elevation + active
  -- focus. Focus is foreground strength, so inactive shares the same bg.
  StatusLine = "chrome_active",

  -- hl-StatusLineNC
  -- Status lines of not-current windows. Same raised surface, muted (inactive) fg.
  StatusLineNC = "chrome_inactive",

  -- hl-StatusLineTerm
  -- Status line of |terminal| window.
  StatusLineTerm = "chrome_active",

  -- *hl-StatusLineTermNC
  -- Status line of non-current |terminal| windows.
  StatusLineTermNC = {},

  -- hl-QuickFixLine
  -- Current |quickfix| item in the quickfix window. Combined with
  -- |hl-CursorLine| when the cursor is there. Emphasis: selection.
  QuickFixLine = "selection",

  -- hl-SignColumn
  -- Column where |signs| are displayed.
  SignColumn = "Normal",

  -- hl-WildMenu
  -- Current match in 'wildmenu' completion. Emphasis: selection.
  WildMenu = "selection",

  -- hl-WinBar
  -- Window bar of current window. Chrome surface, active focus (see StatusLine).
  WinBar = "chrome_active",

  -- hl-WinBarNC
  -- Window bar of not-current windows. Same surface, inactive focus.
  WinBarNC = "chrome_inactive",

  -- hl-ComplMatchIns
  -- Matched text of the currently inserted completion.
  ComplMatchIns = {},

  -- hl-SnippetTabstop
  -- Tabstops in snippets. |vim.snippet|
  SnippetTabstop = {},

  -- hl-Conceal
  -- Placeholder characters substituted for concealed text. Meta -> recedes.
  -- (Was {} -> leaked an off-palette gray.)
  Conceal = "recede",

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
  NonText = "recede",

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
  -- Visual mode selection. Emphasis: selection (the canonical "selected" look).
  Visual = "selection",

  -- hl-VisualNOS
  -- Visual mode selection when vim is "Not Owning the Selection".
  VisualNOS = {},

  -- hl-Whitespace
  -- "nbsp", "space", "tab", "multispace", "lead" and "trail"
  -- in 'listchars'.
  Whitespace = {},
}
