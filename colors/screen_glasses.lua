--- Initialization {{{
local register_colorscheme = function(name, light)
  local bg
  if light then
    bg = "light"
  else
    bg = "dark"
  end

  vim.api.nvim_command("set termguicolors")
  vim.api.nvim_command(string.format('let g:colors_name = "%s"', name))
  vim.api.nvim_command(string.format("set background=%s", bg))
end
register_colorscheme("screen_glasses", false)

--- Initialization }}}

--- Helper Functions {{{

--- Gets a color from the xresource database
---@param key string
---@return string|nil
local load = function(key)
  local color = vim.fn.system({ "xrdb", "-get", key }):gsub("\n", "")
  if not color or color == "" or not color:match("#%x%x%x%x%x%x") then
    return nil
  end
  return color
end

---@class ScreenGlassesXresource
---@field name string
---@field xresource string|nil
---@field fallback string

---@param xresources ScreenGlassesXresource[]
---@return table<string, string>
local resolve = function(xresources)
  local palette = {}
  for _, color in ipairs(xresources) do
    palette[color.name] = load(color.xresource) or color.fallback
  end
  return palette
end

--- Helper Functions }}}

-- Color Palette {{{

---@type ScreenGlassesXresource[]
local color_palette_resources = {
  {
    name = "white",
    xresource = load("color7"),
    fallback = "#ebdbb2",
  },
  {
    name = "black",
    xresource = load("color0"),
    fallback = "#575757",
  },
  {
    name = "red",
    xresource = load("color1"),
    fallback = "#bd7671",
  },
  {
    name = "green",
    xresource = load("color2"),
    fallback = "#769482",
  },
  {
    name = "blue",
    xresource = load("color4"),
    fallback = "#5692db",
  },
  {
    name = "yellow",
    xresource = load("color3"),
    fallback = "#c2c27c",
  },
  {
    name = "cyan",
    xresource = load("color6"),
    fallback = "#7b919e",
  },
  {
    name = "magenta",
    xresource = load("color5"),
    fallback = "#8f7099",
  },
  -- Bright
  {
    name = "bright_white",
    xresource = load("color15"),
    fallback = "#fff2d1",
  },
  {
    name = "bright_black",
    xresource = load("color8"),
    fallback = "#737373",
  },
  {
    name = "bright_red",
    xresource = load("color9"),
    fallback = "#ffa099",
  },
  {
    name = "bright_green",
    xresource = load("color10"),
    fallback = "#b9d9b8",
  },
  {
    name = "bright_blue",
    xresource = load("color12"),
    fallback = "#77b3fc",
  },
  {
    name = "bright_yellow",
    xresource = load("color11"),
    fallback = "#fcfca4",
  },
  {
    name = "bright_cyan",
    xresource = load("color14"),
    fallback = "#a7cacc",
  },
  {
    name = "bright_magenta",
    xresource = load("color13"),
    fallback = "#c99fd6",
  },
  -- Extended Colors
  {
    name = "rose",
    xresource = load("screen_glasses.ui.rose"),
    fallback = "#c08081",
  },
  {
    name = "orange",
    xresource = load("screen_glasses.ui.orange"),
    fallback = "#ce9178",
  },
  {
    name = "violet",
    xresource = load("screen_glasses.ui.violet"),
    fallback = "#8a7b9e",
  },
  {
    name = "bright_violet",
    xresource = load("screen_glasses.ui.bright_violet"),
    fallback = "#eebaff",
  },
  {
    name = "brown",
    xresource = load("screen_glasses.ui.brown"),
    fallback = "#473d37",
  },
  {
    name = "gold",
    xresource = load("screen_glasses.ui.gold"),
    fallback = "#a38e5d",
  },
  {
    name = "dark_gray",
    xresource = load("screen_glasses.ui.gray_10"),
    fallback = "#1a1a1a",
  },
  {
    name = "gray",
    xresource = load("screen_glasses.ui.gray_34"),
    fallback = "#575757",
  },
  {
    name = "bright_gray",
    xresource = load("screen_glasses.ui.gray_50"),
    fallback = "#333333",
  },
  {
    name = "dark_blue",
    xresource = load("screen_glasses.ui.resolution_blue"),
    fallback = "#202080",
  },
}

--- Color Palette }}}

--- UI Palette {{{

local ui_palette_resources = {
  {
    name = "panel_foreground",
    xresource = load("not_implemented"),
    fallback = "#a89984",
  },
  {
    name = "panel_background",
    xresource = load("screen_glasses.ui.secondary_background"),
    fallback = "#504945",
  },
  {
    name = "bright_panel_foreground",
    xresource = load("not_implemented"),
    fallback = "#191816",
  },
  {
    name = "bright_panel_background",
    xresource = load("screen_glasses.ui.tertiary_background"),
    fallback = "#a89984",
  },
  {
    name = "dark_panel_foreground",
    xresource = load("screen_glasses.ui.primary_foreground"),
    fallback = "#a6977c",
  },
  {
    name = "dark_panel_background",
    xresource = load("screen_glasses.ui.primary_background"),
    fallback = "#2C2826",
  },
  {
    name = "cursor_line_background",
    xresource_name = load("screen_glasses.ui.cursor_line_background"),
    fallback = "#1f1d1b",
  },
  {
    name = "background",
    xresource = load("background"),
    fallback = "#191816",
  },
  {
    name = "foreground",
    xresource = load("foreground"),
    fallback = "#ebdbb2",
  },
}

--- UI Palette }}}

--- ColorBuddy Nonsense {{{

local colorbuddy = require("colorbuddy")
colorbuddy.colorscheme("screen_glasses")
local Color = colorbuddy.Color
local colors = colorbuddy.colors
local Group = colorbuddy.Group
local groups = colorbuddy.groups
local styles = colorbuddy.styles

-- Normal
Color.new("white", load("color7") or "ebdbb2")
Color.new("black", load("color0") or "#575757")
Color.new("red", load("color1") or "#bd7671")
Color.new("green", load("color2") or "#769482")
Color.new("blue", load("color4") or "#5692db")
Color.new("yellow", load("color3") or "#c2c27c")
Color.new("cyan", load("color6") or "#7b919e")
Color.new("magenta", load("color5") or "#8f7099")
-- Bright
Color.new("bright_white", load("color15") or "#fff2d1")
Color.new("bright_black", load("color8") or "#737373")
Color.new("bright_red", load("color9") or "#ffa099")
Color.new("bright_green", load("color10") or "#b9d9b8")
Color.new("bright_blue", load("color12") or "#77b3fc")
Color.new("bright_yellow", load("color11") or "#fcfca4")
Color.new("bright_cyan", load("color14") or "#a7cacc")
Color.new("bright_magenta", load("color13") or "#c99fd6")
-- Extended Colors
Color.new("rose", load("screen_glasses.ui.rose") or "#c08081")
Color.new("orange", load("screen_glasses.ui.orange") or "#ce9178")
Color.new("violet", load("screen_glasses.ui.violet") or "#8a7b9e")
Color.new("bright_violet", load("screen_glasses.ui.bright_violet") or "#eebaff")
Color.new("brown", load("screen_glasses.ui.brown") or "#473d37")
Color.new("gold", load("screen_glasses.ui.gold") or "#a38e5d")
Color.new("gray_10", load("screen_glasses.ui.gray_10") or "#1a1a1a")
Color.new("gray_34", load("screen_glasses.ui.gray_34") or "#575757")
Color.new("gray_50", load("screen_glasses.ui.gray_50") or "#333333")
Color.new("dark_blue", load("screen_glasses.ui.resolution_blue") or "#202080")
-- UI
Color.new("cursorline", load("screen_glasses.ui.cursor_line_background") or "#1f1d1b")
Color.new("panel_background", load("screen_glasses.ui.secondary_background") or "#504945")
Color.new("light_panel_background", load("screen_glasses.ui.tertiary_background") or "#a89984")
Color.new("dark_panel_foreground", load("screen_glasses.ui.primary_foreground") or "#a6977c")
Color.new("dark_panel_background", load("screen_glasses.ui.primary_background") or "#2C2826")
Color.new("terminal", load("background") or "#191816")

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

-- Panels
Group.new("LightPanel", groups.Background, colors.light_panel_background)
Group.new("Panel", colors.light_panel_background, colors.panel_background)
Group.new("DarkPanel", colors.dark_panel_foreground, colors.dark_panel_background)

-- Shades
Group.new("DarkGray", colors.gray_10)
Group.new("Gray", colors.gray_34)
Group.new("BrightGray", colors.gray_50)

-- Italicized
Group.new("Italicized", nil, nil, styles.italic)
Group.new("GrayItalicized", colors.gray_34, nil, styles.italic)
Group.new("BrightCyanItalicized", colors.bright_cyan, nil, styles.italic)
Group.new("YellowItalicized", colors.yellow, nil, styles.italic)

-- Undercurls
Group.new("RedUndercurl", colors.red, nil, styles.undercurl) -- error
Group.new("YellowUndercurl", colors.yellow, nil, styles.undercurl) -- warn
Group.new("BlueUndercurl", colors.blue, nil, styles.underline) -- info
Group.new("MagentaUndercurl", colors.magenta, nil, styles.undercurl) -- hint
Group.new("GreenUndercurl", colors.green, nil, styles.undercurl) -- ok

-- TODO: Clean up Custom Highlights
Group.new("Border", colors.gray_34, colors.terminal)
Group.new("Understated", colors.brown)
Group.new("UnderstatedInverse", nil, colors.brown)
Group.new("Seperator", colors.panel_background)
Group.link("Match", groups.Green)
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

-- Float
Group.link("FloatBorder", groups.Border)
Group.link("FloatTitle", groups.Normal)

-- Pmenu
Group.new("Pmenu", nil, groups.Background)
Group.new("PmenuSel", nil, colors.dark_panel_background)

-- Search
Group.new("Search", nil, colors.dark_blue) -- No inverse-blue implemented yet
Group.link("CurSearch", groups.Search)
Group.link("IncSearch", groups.Search)
Group.new("Visual", nil, colors.gray_50)

-- Gutter
Group.link("LineNr", groups.Understated)
Group.link("SignColumn", groups.Normal)
-- Group.link("Folded", groups.DarkPanel)
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

-- Styles
Group.link("Comment", groups.GrayItalicized)
Group.link("Boolean", groups.BrightCyanItalicized) -- Boolean constant: TRUE, False
Group.link("FunctionCall", groups.YellowItalicized)

-- Dupes
Group.link("Character", groups.Constant) -- Character constant: 'c', '/n'
Group.link("SpecialChar", groups.Gold) -- Character constant: 'c', '/n'
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

-------------------------------------------------------------------------
-- Diagnostics
-------------------------------------------------------------------------

Group.link("Error", groups.Red)
Group.link("DiagnosticError", groups.Error)
Group.link("DiagnosticSignError", groups.Error)
Group.link("DiagnosticFloatingError", groups.Error)
Group.link("DiagnosticVirtualTextError", groups.Error)
Group.link("DiagnosticUnderlineError", groups.RedUndercurl)

Group.link("Warn", groups.Yellow)
Group.link("DiagnosticWarn", groups.Warn)
Group.link("DiagnosticSignWarn", groups.Warn)
Group.link("DiagnosticFloatingWarn", groups.Warn)
Group.link("DiagnosticVirtualTextWarn", groups.Warn)
Group.link("DiagnosticUnderlineWarn", groups.YellowUndercurl)

Group.link("Info", groups.Blue)
Group.link("DiagnosticInfo", groups.Info)
Group.link("DiagnosticSignInfo", groups.Info)
Group.link("DiagnosticFloatingInfo", groups.Info)
Group.link("DiagnosticVirtualTextInfo", groups.Info)
Group.link("DiagnosticUnderlineInfo", groups.BlueUndercurl)

Group.link("Hint", groups.Magenta)
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

--- ColorBuddy Nonsense }}}

-- Set up color palette
local cp = resolve(color_palette_resources)
local ui = resolve(ui_palette_resources)
for k, v in pairs(cp) do
  vim.api.nvim_set_hl(0, k, { fg = v })
  vim.api.nvim_set_hl(0, string.format("%s_inverse", k), { bg = v })
  vim.api.nvim_set_hl(0, string.format("%s_italic", k), { fg = v, italic = true })
  vim.api.nvim_set_hl(0, string.format("%s_underline", k), { fg = v, underline = true })
  vim.api.nvim_set_hl(0, string.format("%s_undercurl", k), { fg = v, undercurl = true })
end

-- vim.notify(vim.inspect(ui))

-- Set up UI
vim.api.nvim_set_hl(0, "Normal", { fg = ui.foreground, bg = ui.background })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = ui.panel_background })
vim.api.nvim_set_hl(0, "EndOfBUffer", { fg = ui.background })
vim.api.nvim_set_hl(0, "CursorLine", { bg = ui.cursor_line_background })
vim.api.nvim_set_hl(0, "NonText", { fg = cp.brown })
vim.api.nvim_set_hl(0, "Tabline", { fg = cp.bright_black, bg = cp.dark_panel_background })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = ui.foreground, bg = ui.dark_panel_background })
vim.api.nvim_set_hl(0, "TabLineFill", { fg = cp.Red, bg = ui.dark_panel_background })

vim.api.nvim_set_hl(0, "border", { fg = ui.panel_background })
vim.api.nvim_set_hl(0, "dark_panel", { fg = ui.dark_panel_foreground, bg = ui.dark_panel_background })
vim.api.nvim_set_hl(0, "panel", { fg = ui.panel_foreground, bg = ui.panel_background })
vim.api.nvim_set_hl(0, "bright_panel", { fg = ui.bright_panel_foreground, bg = ui.bright_panel_background })
vim.api.nvim_set_hl(0, "visual_muted", { bg = ui.dark_panel_background })

vim.api.nvim_set_hl(0, "bold", { bold = true })

vim.cmd("hi! link ColorColumn CursorLine")
-- Float
vim.cmd("hi! link NormalFloat Normal")
vim.cmd("hi! link FloatBorder Border")
vim.cmd("hi! link FloatTitle Normal")
-- popup menu
vim.cmd("hi! link Pmenu Nommal")
vim.cmd("hi! link PmenuSel panel")
-- Search
vim.cmd("hi! link Search dark_blue_inverse")
vim.cmd("hi! link CurSearch Search")
vim.cmd("hi! link IncSearch Search")
vim.cmd("hi! link Visual bright_gray_inverse")
-- Gutter
vim.cmd("hi! link LineNr NonText")
vim.cmd("hi! link CursorLineNr NonText")
vim.cmd("hi! link SignColumn Normal")
vim.cmd("hi! link Folded dark_panel")
vim.cmd("hi! link FoldColumn Normal")

--------------------------------------------------------------------------------
-- Syntax Highlighting
--------------------------------------------------------------------------------

-- Standard Colors (missing: black)
vim.cmd("hi! link Identifier white") -- variable name
vim.cmd("hi! link Exception red") -- try,catch, throw, etc.
vim.cmd("hi! link Type green") -- generic type
vim.cmd("hi! link Keyword blue") -- generic keyword
vim.cmd("hi! link Function yellow") -- function name
vim.cmd("hi! link Label cyan") -- case, default, etc.
vim.cmd("hi! link Repeat magenta") -- for, do, while, etc.

-- Bright (missing: red, yellow)
vim.cmd("hi! link PreProc bright_blue") -- generic preprocessor
vim.cmd("hi! link Structure bright_green") -- struct, union, enum, ect.
vim.cmd("hi! link Constant bright_cyan") -- generic constant
vim.cmd("hi! link Statement bright_magenta") -- flow control, return, etc.

-- Extended (missing: brown, rose, dark_violet, bright_violet)
vim.cmd("hi! link String orange") -- string constant
vim.cmd("hi! link Special gold") -- generic special
vim.cmd("hi! link Condition violet") -- if, them else, endif switch, etc.

-- Styles
vim.cmd("hi! link Comment gray_italic") -- if, them else, endif switch, etc.
vim.cmd("hi! link Boolean bright_cyan_italic") -- if, them else, endif switch, etc.
vim.cmd("hi! link FunctionCall yellow_italic") -- if, them else, endif switch, etc.

-- Dupes
vim.cmd("hi! link Character Constant") -- Character constant: 'c', '/n'
vim.cmd("hi! link SpecialChar gold") -- Character constant: 'c', '/n'
vim.cmd("hi! link Number Constant") -- Number constant: 234, 0xff
vim.cmd("hi! link Float Constant") -- Floating point constant: 2.3e10
vim.cmd("hi! link Operator Normal") -- sizeof, "+", "*", etc.
vim.cmd("hi! link Include PreProc") -- Preprocessor #include
vim.cmd("hi! link Define PreProc") -- Preprocessor #define
vim.cmd("hi! link Macro PreProc") -- Same as Define
vim.cmd("hi! link PreCondit PreProc") -- Preprocessor #if, #else, #endif, etc.

--------------------------------------------------------------------------------
-- Diff
--------------------------------------------------------------------------------

vim.cmd("hi! link DiffAdd green")
vim.cmd("hi! link DiffChange yellow")
vim.cmd("hi! link DiffDelete red")
vim.cmd("hi! link DiffText orange")

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

vim.api.nvim_set_hl(0, "MarkdownHeading1", { fg = "#998568", bg = "#191816", bold = true })
vim.api.nvim_set_hl(0, "MarkdownHeading2", { fg = "#8c7a5f", bg = "#191816", bold = true })
vim.api.nvim_set_hl(0, "MarkdownHeading3", { fg = "#806f57", bg = "#191816", bold = true })
vim.api.nvim_set_hl(0, "MarkdownHeading4", { fg = "#73644e", bg = "#191816", bold = true })
vim.api.nvim_set_hl(0, "MarkdownHeading5", { fg = "#665945", bg = "#191816", bold = true })
vim.api.nvim_set_hl(0, "MarkdownHeading6", { fg = "#594e3d", bg = "#191816", bold = true })
vim.api.nvim_set_hl(0, "MarkdownCode", { bg = "#1f1e1b" })
