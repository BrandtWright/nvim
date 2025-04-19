--- Initialization {{{

vim.api.nvim_command("set termguicolors")
vim.api.nvim_command("let g:colors_name='screen_glasses'")
vim.api.nvim_command("set background=dark")

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

--- Highlihgts {{{

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

-- Set up UI
vim.api.nvim_set_hl(0, "Normal", { fg = ui.foreground, bg = ui.background })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = ui.panel_background })
vim.api.nvim_set_hl(0, "EndOfBUffer", { fg = ui.background })
vim.api.nvim_set_hl(0, "Tabline", { fg = cp.bright_black, bg = cp.dark_panel_background })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = ui.foreground, bg = ui.dark_panel_background })
vim.api.nvim_set_hl(0, "TabLineFill", { fg = cp.Red, bg = ui.dark_panel_background })
vim.api.nvim_set_hl(0, "CursorLine", { bg = ui.cursor_line_background })
vim.cmd("hi! link ColorColumn CursorLine")
vim.cmd("hi! link NonText brown")

vim.cmd("hi link match green")
vim.cmd("hi link critical bright_red")
vim.cmd("hi link hyperlink bright_blue")
vim.api.nvim_set_hl(0, "border", { fg = ui.panel_background })
vim.api.nvim_set_hl(0, "dark_panel", { fg = ui.dark_panel_foreground, bg = ui.dark_panel_background })
vim.api.nvim_set_hl(0, "panel", { fg = ui.panel_foreground, bg = ui.panel_background })
vim.api.nvim_set_hl(0, "bright_panel", { fg = ui.bright_panel_foreground, bg = ui.bright_panel_background })
vim.api.nvim_set_hl(0, "visual_muted", { bg = ui.dark_panel_background })

vim.api.nvim_set_hl(0, "bold", { bold = true })

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

vim.cmd("hi! link Add green")
vim.cmd("hi! link Added green")
vim.cmd("hi! link DiffAdd Added")
vim.cmd("hi! link DiffAdded Added")
vim.cmd("hi! link DiffChange yellow")
vim.cmd("hi! link DiffChanged yellow")
vim.cmd("hi! link DiffDelete red")
vim.cmd("hi! link DiffRemoved red")
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

--- Hihglights }}}
