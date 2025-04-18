local colorbuddy = require("colorbuddy")
colorbuddy.colorscheme("screen_glasses")

local Color = colorbuddy.Color
local colors = colorbuddy.colors
local Group = colorbuddy.Group
local groups = colorbuddy.groups
local styles = colorbuddy.styles

--- Gets a color from the xresource database
---@param key string
---@return string|nil
local load_color = function(key)
  local color = vim.fn.system({ "xrdb", "-get", key }):gsub("\n", "")
  if not color or color == "" or not color:match("#%x%x%x%x%x%x") then
    return nil
  end
  return color
end

-------------------------------------------------------------------------
-- Groups
-------------------------------------------------------------------------

-- Normal
Color.new("white", load_color("color7") or "ebdbb2")
Color.new("black", load_color("color0") or "#575757")
Color.new("red", load_color("color1") or "#bd7671")
Color.new("green", load_color("color2") or "#769482")
Color.new("blue", load_color("color4") or "#5692db")
Color.new("yellow", load_color("color3") or "#c2c27c")
Color.new("cyan", load_color("color6") or "#7b919e")
Color.new("magenta", load_color("color5") or "#8f7099")
-- Bright
Color.new("bright_white", load_color("color15") or "#fff2d1")
Color.new("bright_black", load_color("color8") or "#737373")
Color.new("bright_red", load_color("color9") or "#ffa099")
Color.new("bright_green", load_color("color10") or "#b9d9b8")
Color.new("bright_blue", load_color("color12") or "#77b3fc")
Color.new("bright_yellow", load_color("color11") or "#fcfca4")
Color.new("bright_cyan", load_color("color14") or "#a7cacc")
Color.new("bright_magenta", load_color("color13") or "#c99fd6")
-- Tertiary Colors
Color.new("rose", load_color("screen_glasses.ui.rose") or "#c08081") -- Not implemented
Color.new("orange", load_color("screen_glasses.ui.orange") or "#ce9178") -- String, WhichKeyGroup
Color.new("dark_violet", load_color("screen_glasses.ui.dark_violet") or "#8a7989") -- @lsp.type.delegateName.cs
Color.new("violet", load_color("screen_glasses.ui.violet") or "#8a7b9e") -- Conditional, Hint
Color.new("bright_violet", load_color("screen_glasses.ui.bright_violet") or "#eebaff") -- Repeat
-- puctuation.special.markdown, float border, CursorLnNumber, LineNumber, ChatGPT, LspInfoBorder, WhichKeyBorder
Color.new("brown", load_color("screen_glasses.ui.brown") or "#473d37")
-- Statement, Statement Special, function.builtin, constant.builtin, lsp.typemod.function, constructor,
-- lsp.tyoe,interface, markup.heading.gitcommit, LazySpecial, markup.list.markdown, FoldColumn,
-- markup.heading.1.vimdoc, RenderMarkdownBullet, TelescopeSelectionCaret, NoiceCmdlinePopupBorder, NoicecmdlineIcon,
-- NoiceCmdlinePopupTitle, MiniIndestscopeSymbol, WhichKeyDesc
Color.new("gold", load_color("screen_glasses.ui.gold") or "#a38e5d") -- Lots of LSP stuff
-- Terminal (Normal Background)
Color.new("terminal", load_color("background") or "#191816")
-- ColorColumn, TelescopeSelection
Color.new("gray_10", load_color("screen_glasses.ui.gray_10") or "#1a1a1a")
-- Comment, @Comment, @lsp.type.comment
Color.new("gray_34", load_color("screen_glasses.ui.gray_34") or "#575757")
-- Visual
Color.new("gray_50", load_color("screen_glasses.ui.gray_50") or "#333333")
-- Search, CurrentSearch, IncSearch
Color.new("dark_blue", load_color("screen_glasses.ui.resolution_blue") or "#202080")
Color.new("cursorline", load_color("screen_glasses.ui.cursor_line_background") or "#1f1d1b")
Color.new("panel_background", load_color("screen_glasses.ui.secondary_background") or "#504945")
Color.new("light_panel_background", load_color("screen_glasses.ui.tertiary_background") or "#a89984")
Color.new("dark_panel_foreground", load_color("screen_glasses.ui.primary_foreground") or "#a6977c")
Color.new("dark_panel_background", load_color("screen_glasses.ui.primary_background") or "#2C2826")

-------------------------------------------------------------------------
-- Color Pallette
-------------------------------------------------------------------------

-- Foreground and Background
Group.new("Foreground", colors.white, colors.white)
Group.new("Background", colors.terminal, colors.terminal)
Group.new("Normal", groups.Foreground, groups.Background)

-- Standard Colors
Group.new("White", colors.white)
Group.new("Black", colors.black)
Group.new("Red", colors.red)
Group.new("Green", colors.green)
Group.new("Blue", colors.blue)
Group.new("Yellow", colors.yellow)
Group.new("Cyan", colors.cyan)
Group.new("Magenta", colors.magenta)

-- Bright Colors
Group.new("BrightWhite", colors.bright_white)
Group.new("BrightBlack", colors.bright_black)
Group.new("BrightRed", colors.bright_red)
Group.new("BrightGreen", colors.bright_green)
Group.new("BrightBlue", colors.bright_blue)
Group.new("BrightYellow", colors.bright_yellow)
Group.new("BrightCyan", colors.bright_cyan)
Group.new("BrightMagenta", colors.bright_magenta)

-- Extended Colors
Group.new("Orange", colors.orange)
Group.new("Brown", colors.brown)
Group.new("Gold", colors.gold)
Group.new("DarkBlue", colors.dark_blue)
Group.new("Rose", colors.rose)
Group.new("Violet", colors.violet)
Group.new("DarkViolet", colors.dark_violet)
Group.new("BrightViolet", colors.bright_violet)
Group.new("LightPanel", groups.Background, colors.light_panel_background)
Group.new("Panel", colors.light_panel_background, colors.panel_background)
Group.new("DarkPanel", colors.dark_panel_foreground, colors.dark_panel_background)

-- Shades
Group.new("DarkGray", colors.gray_10)
Group.new("Gray", colors.gray_34)
Group.new("LightGray", colors.gray_50)

-- Italicized
Group.new("Italicized", nil, nil, styles.italic)
Group.new("GrayItalicized", colors.gray_34, nil, styles.italic)
Group.new("BrightCyanItalicized", colors.bright_cyan, nil, styles.italic)

-- Undercurls
Group.new("RedUndercurl", colors.red, nil, styles.undercurl) -- error
Group.new("YellowUndercurl", colors.yellow, nil, styles.undercurl) -- warn
Group.new("BlueUndercurl", colors.blue, nil, styles.underline) -- info
Group.new("MagentaUndercurl", colors.magenta, nil, styles.undercurl) -- hint
Group.new("GreenUndercurl", colors.green, nil, styles.undercurl) -- ok

-- Bold
Group.new("Bold", nil, nil, styles.bold)
Group.new("BrightBlueBold", colors.bright_blue, nil, styles.bold)

-- Bright Italics
Group.link("Boolean", groups.BrightCyanItalicized) -- Boolean constant: TRUE, False

-- TODO: Clean up Custom Highlights
Group.new("Border", colors.panel_background)
Group.new("Understated", colors.brown)
Group.new("UnderstatedInverse", nil, colors.brown)
Group.new("Seperator", colors.panel_background)
Group.new("Match", colors.green)
Group.new("Critical", colors.bright_red)
Group.new("HyperLink", colors.bright_blue)

-- Window
Group.link("WinSeparator", groups.Seperator)
Group.link("EndOfBUffer", groups.Background)
Group.link("CursorLineNr", groups.Understated)
Group.link("ColorColumn", groups.CursorLine)
Group.link("NormalFloat", groups.Normal)
Group.new("CursorLine", nil, colors.cursorline)
Group.new("TabLine", colors.bright_black, colors.dark_panel_background)
Group.new("TabLineSel", groups.Foreground, colors.dark_panel_background)
Group.new("TabLineFill", colors.red, colors.dark_panel_background)

-- Floating Window
Group.link("FloatBorder", groups.Border)
Group.link("FloatTitle", groups.Normal)

-- Pmenu
Group.new("Pmenu", nil, groups.Background)
Group.new("PmenuSel", nil, colors.dark_panel_background)
Group.link("Comment", groups.GrayItalicized)

-- Search
Group.new("Search", nil, groups.DarkBlue)
Group.link("CurSearch", groups.Search)
Group.link("IncSearch", groups.Search)
Group.new("Visual", nil, groups.LightGray)

-- Gutter
Group.link("LineNr", groups.Understated)
Group.link("SignColumn", groups.Normal)
Group.link("Folded", groups.DarkPanel)
Group.link("FoldColumn", groups.Normal) -- Not working?

-------------------------------------------------------------------------
-- Syntax Highlighting
-------------------------------------------------------------------------

-- Standard
Group.link("Identifier", groups.Normal) -- variable name
Group.link("Exception", groups.Red) -- try,catch, throw, etc.
Group.link("Type", groups.Green) -- Generic type
Group.link("Keyword", groups.Blue) -- generickeyword
Group.link("Function", groups.Yellow) -- function name
Group.link("Label", groups.Cyan) -- case, default, etc.
Group.link("Repeat", groups.Magenta) -- for, do, while, etc.

-- Bright (missing: red, yellow)
Group.link("PreProc", groups.BrightBlue) -- Generic preprocessor
Group.link("Structure", groups.BrightGreen) -- struct, union, emum, etc.
Group.link("Constant", groups.BrightCyan) -- generic constant
Group.link("Statement", groups.BrightMagenta) -- flow control, return, etc.

-- Extended (missing: brown, rose, dark_violet, bright_violet)
Group.link("String", groups.Orange) -- string constant
Group.link("Special", groups.Gold) -- generic special
Group.link("Conditional", groups.Violet) -- if, then, else, endif, swicth, etc.

-- Dupes
Group.link("Character", groups.Constant) -- Character constant: 'c', '/n'
Group.link("Number", groups.Constant) -- Number constant: 234, 0xff
Group.link("Float", groups.Constant) -- Floating point constant: 2.3e10
Group.link("Operator", groups.Normal) -- sizeof, "+", "*", etc.

Group.link("Include", groups.PreProc) -- Preprocessor #include
Group.link("Define", groups.PreProc) -- Preprocessor #define
Group.link("Macro", groups.PreProc) -- Same as Define
Group.link("PreCondit", groups.PreProc) -- Preprocessor #if, #else, #endif, etc.

-------------------------------------------------------------------------
-- Instpect
-------------------------------------------------------------------------

-- Diff
Group.new("DiffAdd", groups.Green)
Group.new("DiffChange", groups.Function)
Group.new("DiffDelete", groups.Exception)
Group.new("DiffText", groups.String)

-- Lsp
Group.new("FunctionCall", colors.yellow, nil, styles.italic)

-------------------------------------------------------------------------
-- Highlight Group Links
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Diagnostics
-------------------------------------------------------------------------

Group.link("Error", groups.Exception)
Group.link("DiagnosticError", groups.Error)
Group.link("DiagnosticSignError", groups.Error)
Group.link("DiagnosticFloatingError", groups.Error)
Group.link("DiagnosticVirtualTextError", groups.Error)
Group.link("DiagnosticUnderlineError", groups.RedUndercurl)

Group.link("Warn", groups.Function)
Group.link("DiagnosticWarn", groups.Warn)
Group.link("DiagnosticSignWarn", groups.Warn)
Group.link("DiagnosticFloatingWarn", groups.Warn)
Group.link("DiagnosticVirtualTextWarn", groups.Warn)
Group.link("DiagnosticUnderlineWarn", groups.YellowUndercurl)

Group.link("Info", groups.Keyword)
Group.link("DiagnosticInfo", groups.Info)
Group.link("DiagnosticSignInfo", groups.Info)
Group.link("DiagnosticFloatingInfo", groups.Info)
Group.link("DiagnosticVirtualTextInfo", groups.Info)
Group.link("DiagnosticUnderlineInfo", groups.BlueUndercurl)

Group.link("Hint", groups.Conditional)
Group.link("DiagnosticHint", groups.Hint)
Group.link("DiagnosticSignHint", groups.Hint)
Group.link("DiagnosticFloatingHint", groups.Hint)
Group.link("DiagnosticVirtualTextHint", groups.Hint)
Group.link("DiagnosticUnderlineHint", groups.MagentaUndercurl)

Group.link("Ok", groups.Green)
Group.link("DiagnosticOk", groups.Ok)
Group.link("DiagnosticSignOk", groups.Ok)
Group.link("DiagnosticFloatingOk", groups.Ok)
Group.link("DiagnosticVirtualTextOk", groups.Ok)
Group.link("DiagnosticUnderlineOk", groups.GreenUndercurl)

-------------------------------------------------------------------------
-- Move
-------------------------------------------------------------------------
Group.new("LspReferenceRead", nil, nil, styles.bold)
Group.new("LspReferenceText", nil, colors.dark_panel_background)

-------------------------------------------------------------------------
-- Markdown
-------------------------------------------------------------------------
Color.new("MarkdownHeading1", "#998568", groups.Background)
Color.new("MarkdownHeading2", "#8c7a5f", groups.Background)
Color.new("MarkdownHeading3", "#806f57", groups.Background)
Color.new("MarkdownHeading4", "#73644e", groups.Background)
Color.new("MarkdownHeading5", "#665945", groups.Background)
Color.new("MarkdownHeading6", "#594e3d", groups.Background)
Color.new("MarkdownCode", "#1f1e1b")
Group.new("MarkdownHeading1", colors.MarkdownHeading1, groups.Background, styles.bold)
Group.new("MarkdownHeading2", colors.MarkdownHeading2, groups.Background, styles.bold)
Group.new("MarkdownHeading3", colors.MarkdownHeading3, groups.Background, styles.bold)
Group.new("MarkdownHeading4", colors.MarkdownHeading4, groups.Background, styles.bold)
Group.new("MarkdownHeading5", colors.MarkdownHeading5, groups.Background, styles.bold)
Group.new("MarkdownCode", nil, colors.MarkdownCode)
