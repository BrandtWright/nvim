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

local load = require("bw.util.xresources").load
local cp = {
  -- Dark
  -- Normal
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

local highlights = {
  builtins = {
    gruoup_names = {},
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

local temp = {
  lsp_semantic_highlights = {},
  treesitter_highlights = {},
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

-- diff
-- plugins
-- applications (git, )
-- languages
-- file typpes

-------------------------------------------------------------------------------
-- Colors
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Highlights
-------------------------------------------------------------------------------

-- Syntax Groups

-- Builtin Highlight Groups

-- Semantic Tokens

-- Extmarks and Virtual Text
