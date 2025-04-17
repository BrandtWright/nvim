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
Color.new("black", load_color("color0") or "#575757")
Color.new("red", load_color("color1") or "#bd7671")
Color.new("green", load_color("color2") or "#769482")
Color.new("yellow", load_color("color3") or "#c2c27c")
Color.new("blue", load_color("color4") or "#5692db")
Color.new("magenta", load_color("color5") or "#8f7099")
Color.new("cyan", load_color("color6") or "#7b919e")
Color.new("white", load_color("color7") or "ebdbb2")
-- Bright
Color.new("bright_black", load_color("color8") or "#737373")
Color.new("bright_red", load_color("color9") or "#ffa099")
Color.new("bright_green", load_color("color10") or "#b9d9b8")
Color.new("bright_yellow", load_color("color11") or "#fcfca4")
Color.new("bright_blue", load_color("color12") or "#77b3fc")
Color.new("bright_magenta", load_color("color13") or "#c99fd6")
Color.new("bright_cyan", load_color("color14") or "#a7cacc")
Color.new("bright_white", load_color("color15") or "#fff2d1")
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
Color.new("gray_20", load_color("screen_glasses.ui.gray_50") or "#333333")
-- Search, CurrentSearch, IncSearch
Color.new("resolution_blue", load_color("screen_glasses.ui.resolution_blue") or "#202080")
-- CursorLine
Color.new("cursorline", load_color("screen_glasses.ui.cursor_line_background") or "#1f1d1b")
-- WinSeperator
Color.new("win_seperator", load_color("screen_glasses.ui.secondary_background") or "#504945")
-- New
Color.new("panel_foreground", load_color("screen_glasses.ui.primary_foreground") or "#504945")
-- Primary Window Chrome: Tabline, TabLineSel, TabLineFill, Lualine, TelescopeSelection (was raising_balck)
Color.new("panel_background", load_color("screen_glasses.ui.primary_background") or "#2C2826")

-------------------------------------------------------------------------
-- Highlight Group Definitions
-------------------------------------------------------------------------

-- Vim Custom
Group.new("Border", colors.win_seperator)
Group.new("Panel", colors.panel_foreground, colors.panel_background)
Group.new("Understated", colors.brown, colors.terminal)
Group.new("Seperator", colors.win_seperator)
Group.new("Blank", colors.terminal, colors.terminal)
Group.new("Attention", nil, colors.resolution_blue)
Group.new("Match", colors.green)

-- Vim UI
Group.new("Normal", colors.white, colors.terminal)
Group.new("CursorLine", nil, colors.cursorline)
Group.new("TabLine", colors.bright_black, colors.panel_background)
Group.new("TabLineSel", colors.white, colors.panel_background)
Group.new("TabLineFill", colors.red, colors.panel_background)
Group.new("Visual", nil, colors.gray_20)
Group.new("Pmenu", nil, colors.terminal)
Group.new("PmenuSel", nil, colors.panel_background)

-- Standard Colors
Group.new("Identifier", colors.white)
Group.new("Exception", colors.red)
Group.new("Property", colors.green)
Group.new("Keyword", colors.blue)
Group.new("Function", colors.yellow)
Group.new("Repeat", colors.magenta)

-- Bright Colors
Group.new("Constant", colors.bright_cyan)
Group.new("Structure", colors.bright_green)
Group.new("HyperLink", colors.bright_blue)

-- Bright Italics
Group.new("Boolean", colors.bright_cyan, nil, styles.italic)

-- Extended Colors
Group.new("String", colors.orange, nil)
Group.new("Statement", colors.violet, nil) -- Used to be gold
Group.new("Comment", colors.gray_34, nil)
Group.new("Special", colors.gold, nil)

-- Underlines (Find better names here?)
Group.new("IdentifierUnderline", colors.white, nil, styles.underline)
Group.new("ExceptionUnderline", colors.red, nil, styles.underline)
Group.new("PropertyUnderline", colors.green, nil, styles.underline)
Group.new("KeywordUnderline", colors.blue, nil, styles.underline)
Group.new("FunctionUnderline", colors.yellow, nil, styles.underline)
Group.new("RepeatUnderline", colors.magenta, nil, styles.underline)
Group.new("BooleanUnderline", colors.cyan, nil, styles.underline)
Group.new("StringUnderline", colors.orange, nil, styles.underline)
Group.new("StatementUnderline", colors.violet, nil, styles.underline) -- Used to be gold
Group.new("CommentUnderline", colors.gray_34, nil, styles.underline)
Group.new("SpecialUnderline", colors.gold, nil, styles.underline)

-- Lsp
Group.new("FunctionCall", colors.yellow, nil, styles.italic)

-------------------------------------------------------------------------
-- Highlight Group Links
-------------------------------------------------------------------------

-- Vim UI
Group.link("WinSeparator", groups.Seperator)
Group.link("EndOfBUffer", groups.Blank)
Group.link("LineNr", groups.Understated)
Group.link("CursorLineNr", groups.Understated)
Group.link("SignColumn", groups.Normal)
Group.link("ColorColumn", groups.CursorLine)
Group.link("NormalFloat", groups.Normal)
Group.link("FloatBorder", groups.Border)
Group.link("FloatTitle", groups.Normal)
Group.link("Search", groups.Attention)
Group.link("CurSearch", groups.Search)
Group.link("IncSearch", groups.Search)

-------------------------------------------------------------------------
-- Diagnostics
-------------------------------------------------------------------------
Group.link("Error", groups.Exception)
Group.link("DiagnosticError", groups.Error)
Group.link("DiagnosticSignError", groups.Error)
Group.link("DiagnosticFloatingError", groups.Error)
Group.link("DiagnosticVirtualTextError", groups.Error)
Group.link("DiagnosticUnderlineError", groups.ExceptionUnderline)

Group.link("Warn", groups.Function)
Group.link("DiagnosticWarn", groups.Warn)
Group.link("DiagnosticSignWarn", groups.Warn)
Group.link("DiagnosticFloatingWarn", groups.Warn)
Group.link("DiagnosticVirtualTextWarn", groups.Warn)
Group.link("DiagnosticUnderlineWarn", groups.FunctionUnderline)

Group.link("Info", groups.Keyword)
Group.link("DiagnosticInfo", groups.Info)
Group.link("DiagnosticSignInfo", groups.Info)
Group.link("DiagnosticFloatingInfo", groups.Info)
Group.link("DiagnosticVirtualTextInfo", groups.Info)
Group.link("DiagnosticUnderlineInfo", groups.KeywordUnderline)

Group.link("Hint", groups.Statement)
Group.link("DiagnosticHint", groups.Hint)
Group.link("DiagnosticSignHint", groups.Hint)
Group.link("DiagnosticFloatingHint", groups.Hint)
Group.link("DiagnosticVirtualTextHint", groups.Hint)
Group.link("DiagnosticUnderlineHint", groups.StatementUnderline)

Group.link("Ok", groups.Property)
Group.link("DiagnosticOk", groups.Ok)
Group.link("DiagnosticSignOk", groups.Ok)
Group.link("DiagnosticFloatingOk", groups.Ok)
Group.link("DiagnosticVirtualTextOk", groups.Ok)
Group.link("DiagnosticUnderlineOk", groups.PropertyUnderline)

-------------------------------------------------------------------------
-- Diff
-------------------------------------------------------------------------
Group.link("DiffAdd", groups.Identifier)
Group.link("DiffChange", groups.Function)
Group.link("DiffDelete", groups.Exception)
Group.link("DiffText", groups.Keyword)

-------------------------------------------------------------------------
-- Move
-------------------------------------------------------------------------
Group.new("LspReferenceRead", nil, nil, styles.bold)
Group.new("LspReferenceText", nil, colors.panel_background)

-------------------------------------------------------------------------
-- Markdown
-------------------------------------------------------------------------
Color.new("MarkdownHeading1", "#998568", colors.terminal)
Color.new("MarkdownHeading2", "#8c7a5f", colors.terminal)
Color.new("MarkdownHeading3", "#806f57", colors.terminal)
Color.new("MarkdownHeading4", "#73644e", colors.terminal)
Color.new("MarkdownHeading5", "#665945", colors.terminal)
Color.new("MarkdownHeading6", "#594e3d", colors.terminal)
Color.new("MarkdownCode", "#1f1e1b")
Group.new("MarkdownHeading1", colors.MarkdownHeading1, colors.terminal, styles.bold)
Group.new("MarkdownHeading2", colors.MarkdownHeading2, colors.terminal, styles.bold)
Group.new("MarkdownHeading3", colors.MarkdownHeading3, colors.terminal, styles.bold)
Group.new("MarkdownHeading4", colors.MarkdownHeading4, colors.terminal, styles.bold)
Group.new("MarkdownHeading5", colors.MarkdownHeading5, colors.terminal, styles.bold)
Group.new("MarkdownCode", nil, colors.MarkdownCode)
