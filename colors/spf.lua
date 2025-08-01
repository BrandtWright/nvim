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
      ["String"] = { fg = red, bg = "#0000ff" },
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

-------------------------------------------------------------------------------
-- Highlights
-------------------------------------------------------------------------------

apply_highlights(highlights)
