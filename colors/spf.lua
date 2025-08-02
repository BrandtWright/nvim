-------------------------------------------------------------------------------
-- SPF
--
-- This file is part of the SPF color scheme for Neovim.
--
-- See :help
--    - group-name
--    - highlight-groups
--    - diagnostic-highlights
--    - lsp-highlight
--    - lsp-semantic-highlight
--    - treesitter-highlight-groups
--    - extmark
-- See syntax config::
-- - /usr/share/nvim/runtime/syntax/
-- - ~/.config/nvim/after/syntax/
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Colors
-------------------------------------------------------------------------------

-- Base
local foreground = "#ebdbb2"
local background = "#191816"
local cursor_line = "#1f1d1b"

-- Color Palette
local red_dark = "#b25f57"
local red = "#bd7671"
local red_bright = "#e7a3a4"
local orange_dark = "#a1633f"
local orange = "#d28445"
local orange_bright = "#f2b27b"
local yellow_dark = "#b9b237"
local yellow = "#e5dc6c"
local yellow_bright = "#f6f0a4"
local chartreuse_dark = "#758e57"
local chartreuse = "#91b76b"
local chartreuse_bright = "#cfeaa0"
local green_dark = "#4b6550"
local green = "#709d81"
local green_bright = "#b0d4b2"
local spring_dark = "#4f766e"
local spring = "#6da89e"
local spring_bright = "#a9d5c8"
local cyan_dark = "#536a71"
local cyan = "#6c97a7"
local cyan_bright = "#94bfc8"
local azure_dark = "#45667e"
local azure = "#5f87a6"
local azure_bright = "#a2c5e4"
local blue_dark = "#3f6999"
local blue = "#5692db"
local blue_bright = "#7aaadd"
local violet_dark = "#59497c"
local violet = "#8c70b6"
local violet_bright = "#c5afe4"
local magenta_dark = "#5f4469"
local magenta = "#a474b0"
local magenta_bright = "#d6a3e0"
local rose_dark = "#94586b"
local rose = "#c97e95"
local rose_bright = "#e8a9bb"
local black_dark = "#2a2a2a"
local black = "#3c3c3c"
local black_bright = "#666666"
local white_dark = "#a89f91"
local white = "#ebdbb2"
local white_bright = "#fff2d1"

-- UI
local ui_primary_foreground = "#a6977c"
local ui_primary_background = "#2c2826"
local ui_secondary_background = "#504945"
local ui_tertiary_background = "#a89984"

-------------------------------------------------------------------------------
-- Highlights
-------------------------------------------------------------------------------

-- diff
-- plugins
-- applications (git, )
-- languages
-- file typpes

-- lsp_semantic_highlights
-- treesitter_highlights

-- Syntax Groups
-- Builtin Highlight Groups
-- Semantic Tokens
-- Extmarks and Virtual Text

local highlights = {
  builtins = {
    gruoup_names = {
      ["EndOfBUffer"] = { fg = background, bg = background },

      -- hl-ColorColumn
      -- Used for the columns set with 'colorcolumn'.
      ["ColorColumn"] = {},

      -- hl-Conceal
      -- Placeholder characters substituted for concealed
      ["Conceal"] = {},

      -- hl-CurSearch
      -- Current match for the last search pattern (see 'hlsearch').
      --    Note: This is correct after a search, but may get outdated if
      --    changes are made or the screen is redrawn.
      ["CurSearch"] = { link = "Search" },

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
      ["CursorLine"] = {},

      -- hl-Directory
      -- Directory names (and other special names in listings).
      ["Directory"] = {},

      -- hl-DiffAdd
      -- Diff mode: Added line. |diff.txt|
      ["DiffAdd"] = {},

      -- hl-DiffChange
      -- Diff mode: Changed line. |diff.txt|
      ["DiffChange"] = {},

      -- hl-DiffDelete
      -- Diff mode: Deleted line. |diff.txt|
      ["DiffDelete"] = {},

      -- hl-DiffText
      -- Diff mode: Changed text within a changed line. |diff.txt|
      ["DiffText"] = {},

      -- hl-EndOfBuffer
      -- Filler lines (~) after the end of the buffer.
      -- By default, this is highlighted like |hl-NonText|.
      ["EndOfBuffer"] = {},

      -- hl-TermCursor
      -- Cursor in a focused terminal.
      ["TermCursor"] = {},

      -- hl-ErrorMsg
      -- Error messages on the command line.
      ["ErrorMsg"] = {},

      -- hl-WinSeparator
      -- Separators between window splits.
      ["WinSeparator"] = { fg = ui_primary_background, bg = background },

      -- hl-Folded
      -- Line used for closed folds.
      ["Folded"] = {},

      -- hl-FoldColumn
      -- 'foldcolumn'
      ["FoldColumn"] = {},

      -- hl-SignColumn
      -- Column where |signs| are displayed.
      ["SignColumn"] = {},

      -- hl-IncSearch
      -- 'incsearch' highlighting; also used for the text replaced with
      -- ":s///c".
      ["IncSearch"] = { link = "Search" },

      -- hl-Substitute
      -- |:substitute| replacement text highlighting.
      ["Substitute"] = {},

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

      -- hl-MatchParen
      -- Character under the cursor or just before it, if it
      -- is a paired bracket, and its match. |pi_paren.txt|
      ["MatchParen"] = {},

      -- hl-ModeMsg
      -- 'showmode' message (e.g., "-- INSERT --").
      ["ModeMsg"] = {},

      -- hl-MsgArea
      -- Area for messages and command-line, see also 'cmdheight'.
      ["MsgArea"] = {},

      -- hl-MsgSeparator
      -- Separator for scrolled messages |msgsep|.
      ["MsgSeparator"] = {},

      -- hl-MoreMsg
      -- |more-prompt|
      ["MoreMsg"] = {},

      -- hl-NonText
      -- and other characters that do not really exist in the text
      -- (e.g., ">" displayed when a double-wide character doesn't
      -- fit at the end of the line). See also |hl-EndOfBuffer|.
      -- '@' at the end of the window, characters from 'showbreak'
      ["NonText"] = {},

      -- hl-Normal
      -- Normal text.
      ["Normal"] = { fg = foreground, bg = background },

      -- hl-NormalFloat
      -- Normal text in floating windows.
      ["NormalFloat"] = { fg = foreground, bg = background },

      -- hl-FloatBorder
      -- Border of floating windows.
      ["FloatBorder"] = { fg = black_bright, bg = background },

      -- hl-FloatTitle
      -- Title of floating windows.
      ["FloatTitle"] = { fg = black_bright, bg = background, bold = true },

      -- hl-FloatFooter
      -- Footer of floating windows.
      ["FloatFooter"] = { fg = black, bg = background },

      -- hl-NormalNC
      -- Normal text in non-current windows.
      ["NormalNC"] = {},

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

      -- hl-ComplMatchIns
      -- Matched text of the currently inserted completion.
      ["ComplMatchIns"] = {},

      -- hl-Question
      -- |hit-enter| prompt and yes/no questions.
      ["Question"] = {},

      -- hl-QuickFixLine
      -- Current |quickfix| item in the quickfix window. Combined with
      -- |hl-CursorLine| when the cursor is there.
      ["QuickFixLine"] = {},

      -- hl-Search
      -- Last search pattern highlighting (see 'hlsearch').
      -- Also used for similar items that need to stand out.
      ["Search"] = { fg = "", bg = black_bright },

      -- hl-SnippetTabstop
      -- Tabstops in snippets. |vim.snippet|
      ["SnippetTabstop"] = {},

      -- hl-SpecialKey
      -- Unprintable characters: Text displayed differently from what
      -- it really is. But not 'listchars' whitespace. |hl-Whitespace|
      ["SpecialKey"] = {},

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

      -- hl-TabLine
      -- Tab pages line, not active tab page label.
      ["Tabline"] = { fg = ui_primary_foreground, bg = ui_secondary_background },

      -- hl-TabLineFill
      -- Tab pages line, where there are no labels.
      ["TabLineFill"] = { fg = red, bg = ui_primary_background },

      -- hl-TabLineSel
      -- Tab pages line, active tab page label.
      ["TabLineSel"] = { fg = background, bg = ui_tertiary_background },

      -- hl-Title
      -- Titles for output from ":set all", ":autocmd" etc.
      ["Title"] = {},

      -- hl-Visual
      -- Visual mode selection.
      ["Visual"] = {},

      -- hl-VisualNOS
      -- Visual mode selection when vim is "Not Owning the Selection".
      ["VisualNOS"] = {},

      -- hl-WarningMsg
      -- Warning messages.
      ["WarningMsg"] = {},

      -- hl-Whitespace
      -- "nbsp", "space", "tab", "multispace", "lead" and "trail"
      -- in 'listchars'.
      ["Whitespace"] = {},

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
    highlight_groups = {},
    diagnostic_highlights = {},
    lsp_highlights = {},
    lsp_semantic_highlights = {},
  },
  common = {
    git = {},
  },
  plugins = {},
  languages = {},
}

local function apply_highlights(table)
  for name, value in pairs(table) do
    if value.fg or value.link then
      vim.api.nvim_set_hl(0, name, value)
    elseif type(value) == "table" then
      apply_highlights(value)
    end
  end
end

apply_highlights(highlights)
