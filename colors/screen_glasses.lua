-------------------------------------------------------------------------
-- Screen Glasses
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Helper Functions
-------------------------------------------------------------------------
local highlight = vim.api.nvim_set_hl
local load = require("bw.util.xresources").load

-------------------------------------------------------------------------
-- Color Palette
-------------------------------------------------------------------------

local cp = {
  white = load("color7") or "#ebdbb2",
  black = load("color0") or "#575757",
  red = load("color1") or "#bd7671",
  green = load("color2") or "#769482",
  blue = load("color4") or "#5692db",
  yellow = load("color3") or "#c2c27c",
  cyan = load("color6") or "#7b919e",
  magenta = load("color5") or "#8f7099",
  -- Bright
  bright_white = load("color15") or "#fff2d1",
  bright_black = load("color8") or "#737373",
  bright_red = load("color9") or "#ffa099",
  bright_green = load("color10") or "#b9d9b8",
  bright_blue = load("color12") or "#77b3fc",
  bright_yellow = load("color11") or "#fcfca4",
  bright_cyan = load("color14") or "#a7cacc",
  bright_magenta = load("color13") or "#c99fd6",
  --  Extended Colors
  rose = load("screen_glasses.ui.rose") or "#c08081",
  orange = load("screen_glasses.ui.orange") or "#ce9178",
  violet = load("screen_glasses.ui.violet") or "#8a7b9e",
  bright_violet = load("screen_glasses.ui.bright_violet") or "#eebaff",
  brown = load("screen_glasses.ui.brown") or "#473d37",
  gold = load("screen_glasses.ui.gold") or "#a38e5d",
  dark_gray = load("screen_glasses.ui.gray_10") or "#1a1a1a",
  gray = load("screen_glasses.ui.gray_34") or "#575757",
  bright_gray = load("screen_glasses.ui.gray_50") or "#333333",
  dark_blue = load("screen_glasses.ui.resolution_blue") or "#202080",
}

local ui = {
  foreground = load("foreground") or "#ebdbb2",
  background = load("background") or "#191816",
  cursor_line = load("screen_glasses.ui.cursor_line_background") or "#1f1d1b",
  panel_foreground = load("not_implemented") or "#a89984",
  panel_background = load("screen_glasses.ui.secondary_background") or "#504945",
  bright_panel_foreground = load("not_implemented") or "#191816",
  bright_panel_background = load("screen_glasses.ui.tertiary_background") or "#a89984",
  dark_panel_foreground = load("screen_glasses.ui.primary_foreground") or "#a6977c",
  dark_panel_background = load("screen_glasses.ui.primary_background") or "#2C2826",
}

--- Clear all highlights and initialize the color scheme name
vim.cmd("highlight clear")
vim.api.nvim_command("syntax reset")
vim.g.colors_name = "screen_glasses"

--------------------------------------------------------------------------------
-- Color Groups and Styles
--------------------------------------------------------------------------------

for k, v in pairs(cp) do
  highlight(0, k, { fg = v })
  highlight(0, string.format("%s_background", k), { bg = v })
  highlight(0, string.format("%s_inverse", k), { fg = ui.background, bg = v })
  highlight(0, string.format("%s_italic", k), { fg = v, italic = true })
  highlight(0, string.format("%s_underline", k), { fg = v, underline = true })
  highlight(0, string.format("%s_undercurl", k), { fg = v, undercurl = true })
  highlight(0, string.format("%s_bold", k), { fg = v, bold = true })
end
highlight(0, "Underlined", { underline = true })
highlight(0, "Italicized", { italic = true })
highlight(0, "Undercurled", { undercurl = true })
highlight(0, "Bold", { bold = true })

--------------------------------------------------------------------------------
-- Custom UI
--------------------------------------------------------------------------------

vim.cmd("hi link match green")
vim.cmd("hi link critical bright_red")
vim.cmd("hi link hyperlink bright_blue")
highlight(0, "dark_panel", { fg = ui.dark_panel_foreground, bg = ui.dark_panel_background, default = true })
highlight(0, "dark_panel_inverse", { fg = ui.dark_panel_background, bg = ui.dark_panel_foreground })
highlight(0, "dark_panel_ignore", { fg = ui.dark_panel_background, bg = ui.dark_panel_background })
highlight(0, "dark_panel_normal_background", { fg = ui.dark_panel_background, bg = ui.background })
highlight(0, "panel", { fg = ui.panel_foreground, bg = ui.panel_background })
highlight(0, "panel_inverse", { fg = ui.panel_background, bg = ui.panel_foreground })
highlight(0, "panel_ignore", { fg = ui.panel_background, bg = ui.panel_background })
highlight(0, "panel_normal_background", { fg = ui.panel_background, bg = ui.background })
highlight(0, "bright_panel", { fg = ui.bright_panel_foreground, bg = ui.bright_panel_background })
highlight(0, "bright_panel_inverse", { fg = ui.bright_panel_background, bg = ui.bright_panel_foreground })
highlight(0, "bright_panel_ignore", { fg = ui.bright_panel_background, bg = ui.bright_panel_background })
highlight(0, "bright_panel_normal_background", { fg = ui.bright_panel_foreground, bg = ui.background })
highlight(0, "visual_muted", { bg = ui.dark_panel_background })
highlight(0, "bold", { bold = true })

--------------------------------------------------------------------------------
-- Builtin Highlighting Groups: UI
--------------------------------------------------------------------------------

-- General
highlight(0, "Normal", { fg = ui.foreground, bg = ui.background })
highlight(0, "normal_bold", { fg = ui.foreground, bg = ui.background, bold = true })
highlight(0, "Ignore", { fg = ui.background, bg = ui.background })
highlight(0, "WinSeparator", { fg = ui.panel_background })
highlight(0, "EndOfBUffer", { fg = ui.background })
highlight(0, "MatchParen", { fg = ui.foreground, bg = cp.bright_black, bold = true })
vim.cmd("hi! link NonText black")
vim.cmd("hi! link Visual bright_gray_background")

-- Tabline
highlight(0, "Tabline", { fg = cp.bright_black, bg = ui.dark_panel_background })
highlight(0, "TabLineSel", { fg = ui.foreground, bg = ui.dark_panel_background })
highlight(0, "TabLineFill", { fg = cp.red, bg = ui.dark_panel_background })

-- Cursorline
highlight(0, "CursorLine", { bg = ui.cursor_line })
vim.cmd("hi! link ColorColumn CursorLine")

-- Floats
vim.cmd("hi! link FloatBorder bright_black")
vim.cmd("hi! link FloatBorderInverse bright_black_inverse")
vim.cmd("hi! link NormalFloat Normal")
vim.cmd("hi! link FloatTitle FloatBorder")
vim.cmd("hi! link FloatFooter FloatBrder")

-- Poopup Menu
vim.cmd("hi! link Pmenu Nommal")
vim.cmd("hi! link PmenuSel bright_gray_background")
vim.cmd("hi! link PmenuSbar PmenuSel")
vim.cmd("hi! link PmenuThumb PmenuSel")

-- Search
vim.cmd("hi! link Search dark_blue_background")
vim.cmd("hi! link CurSearch Search")
vim.cmd("hi! link IncSearch Search")

-- Gutter
vim.cmd("hi! link LineNr black")
vim.cmd("hi! link CursorLineNr bright_black")
vim.cmd("hi! link SignColumn Normal")

-- Folds
vim.api.nvim_set_hl(0, "Folded", { fg = cp.bright_black, bg = ui.dark_panel_background, italic = true })
vim.cmd("hi! link FoldColumn Normal")

--------------------------------------------------------------------------------
-- Builtin Highlighting Groups: General
--------------------------------------------------------------------------------

--stylua: ignore start
vim.cmd("hi! link Directory blue")     -- directory names and special names in lists
vim.cmd("hi! link Conceal black")      -- see `:conceallevel`
vim.cmd("hi! link Title normal_bold")  -- Titles for output from ":set all", ":autocmd" etc.
--stylua: ignore end

--------------------------------------------------------------------------------
-- Syntax Highlighting
--------------------------------------------------------------------------------

-- Standard Colors (missing: none)
-- Bright (missing: yellow, white)
-- Extended (missing: brown)

-- stylua: ignore start
vim.cmd("hi! link Comment bright_black")          -- any comment

vim.cmd("hi! link Constant bright_cyan")          -- any constant
vim.cmd("hi! link String orange")                 -- string constant
vim.cmd("hi! link Character Constant")            -- Character constant: 'c', '/n'
vim.cmd("hi! link Number Constant")               -- Number constant: 234, 0xff
vim.cmd("hi! link Boolean bright_cyan_italic")    -- a boolean constant: TRUE, false
vim.cmd("hi! link Float Constant")                -- Floating point constant: 2.3e10

vim.cmd("hi! link Identifier white")              -- variable name
vim.cmd("hi! link Function yellow")               -- function name (also: methods for classes)
vim.cmd("hi! link FunctionCall yellow_italic")    -- Custom: differentiate function names from calls

vim.cmd("hi! link Statement bright_magenta")      -- flow control, return, etc.
vim.cmd("hi! link Conditional Statement")         -- if, them else, endif switch, etc.
vim.cmd("hi! link Repeat Statement")              -- for, do, while, etc.
vim.cmd("hi! link Label cyan")                    -- case, default, etc.
highlight(0, "Operator", { fg = ui.foreground })  -- sizeof, "+", "*", etc.
vim.cmd("hi! link Keyword blue")                  -- generic keyword
vim.cmd("hi! link Exception red")                 -- try,catch, throw, etc.

vim.cmd("hi! link PreProc bright_blue")           -- generic preprocessor
vim.cmd("hi! link Include PreProc")               -- preprocessor #include
vim.cmd("hi! link Define PreProc")                -- preprocessor #define
vim.cmd("hi! link Macro PreProc")                 -- same as Define
vim.cmd("hi! link PreCondit PreProc")             -- preprocessor #if, #else, #endif, etc.

vim.cmd("hi! link Type green")                    -- int long char etc
vim.cmd("hi! link StorageClass bright_red")       -- static, register, volitile, etc.
vim.cmd("hi! link Structure bright_green")        -- struct, union, enum, etc
vim.cmd("hi! link Typedef magenta")               -- a typedef

vim.cmd("hi! link Special gold")                  -- generic special
vim.cmd("hi! link SpecialChar Special")           -- special character in a constant
vim.cmd("hi! link Tag bright_violet")             -- you can use `CTRL-]`
highlight(0, "Delimiter", { fg = ui.foreground }) -- special punctuaation: (, [, {, ;, :, ., ,, etc.
vim.cmd("hi! link SpecialComment Special")        -- special character in a constant
vim.cmd("hi! link Debug violet")                  -- debugging statements

vim.cmd("hi! link Todo blue")                     -- debugging statements
--stylua: ignore end

--------------------------------------------------------------------------------
-- Builtin Highlighting Groups::Diff
--------------------------------------------------------------------------------

-- stylua: ignore start
-- defined in runtime/syntax/diff.vim, not a core group highlight/syntax group
vim.cmd("hi! link Add green") -- generic addd

-- group-name (Normal)
vim.cmd("hi! link Added green")               -- added line in a diff
vim.cmd("hi! link Changed yellow")            -- changed line in a diff
vim.cmd("hi! link Removed red")               -- removed line in a diff

-- Some colorschemes and plugins use these (Normal)
vim.cmd("hi! link DiffAdded Added")           -- added line in a diff
vim.cmd("hi! link DiffChanged Changed")       -- debugging statements
vim.cmd("hi! link DiffRemoved Removed")       -- debugging statements

-- highlight-groups (Inverse)
vim.cmd("hi! link DiffAdd green_inverse")     -- Diff mode: Added line.
vim.cmd("hi! link DiffChange yellow_inverse") -- Diff mode: Changed line.
vim.cmd("hi! link DiffDelete red_inverse")    -- Diff mode: Deleted line.
vim.cmd("hi! link DiffText blue_inverse")     -- Diffmode: Changed line
-- stylua: ignore end

-------------------------------------------------------------------------
-- Diagnostics
-------------------------------------------------------------------------

vim.cmd("hi! link Error red")
vim.cmd("hi! link DiagnosticError Error")
vim.cmd("hi! link DiagnosticSignError Error")
vim.cmd("hi! link DiagnosticFloatingError Error")
vim.cmd("hi! link DiagnosticVirtualTextError Error")
vim.cmd("hi! link DiagnosticUnderlineError red_undercurl")

vim.cmd("hi! link Warn yellow")
vim.cmd("hi! link DiagnosticWarn Warn")
vim.cmd("hi! link DiagnosticSignWarn Warn")
vim.cmd("hi! link DiagnosticFloatingWarn Warn")
vim.cmd("hi! link DiagnosticVirtualTextWarn Warn")
vim.cmd("hi! link DiagnosticUnderlineWarn yellow_undercurl")

vim.cmd("hi! link Info blue")
vim.cmd("hi! link DiagnosticInfo Info")
vim.cmd("hi! link DiagnosticSignInfo Info")
vim.cmd("hi! link DiagnosticFloatingInfo Info")
vim.cmd("hi! link DiagnosticVirtualTextInfo Info")
vim.cmd("hi! link DiagnosticUnderlineInfo blue_undercurl")

vim.cmd("hi! link Hint magenta")
vim.cmd("hi! link DiagnosticHint Hint")
vim.cmd("hi! link DiagnosticSignHint Hint")
vim.cmd("hi! link DiagnosticFloatingHint Hint")
vim.cmd("hi! link DiagnosticVirtualTextHint Hint")
vim.cmd("hi! link DiagnosticUnderlineHint magenta_undercurl")

vim.cmd("hi! link Ok green")
vim.cmd("hi! link DiagnosticOk Ok")
vim.cmd("hi! link DiagnosticSignOk Ok")
vim.cmd("hi! link DiagnosticFloatingOk Ok")
vim.cmd("hi! link DiagnosticVirtualTextOk Ok")
vim.cmd("hi! link DiagnosticUnderlineOk green_undercurl")

-------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------

vim.cmd("hi! link LspReferenceRead bold")
vim.cmd("hi! link LspReferenceText visual_muted")

-------------------------------------------------------------------------
-- Markdown
-------------------------------------------------------------------------

-- vim.api.nvim_set_hl(0, "Folded", { fg = "#888888", bg = "NONE", italic = true })
-- vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#ff0000", bg = "NONE" })

-- vim.api.nvim_set_hl(0, "MarkdownHeading1", { fg = "#998568", bg = "#191816", bold = true })
-- vim.api.nvim_set_hl(0, "MarkdownHeading2", { fg = "#8c7a5f", bg = "#191816", bold = true })
-- vim.api.nvim_set_hl(0, "MarkdownHeading3", { fg = "#806f57", bg = "#191816", bold = true })
-- vim.api.nvim_set_hl(0, "MarkdownHeading4", { fg = "#73644e", bg = "#191816", bold = true })
-- vim.api.nvim_set_hl(0, "MarkdownHeading5", { fg = "#665945", bg = "#191816", bold = true })
-- vim.api.nvim_set_hl(0, "MarkdownHeading6", { fg = "#594e3d", bg = "#191816", bold = true })
-- vim.api.nvim_set_hl(0, "MarkdownCode", { bg = "#1f1e1b" })
