-- SPF colorscheme.
--
-- Assembles the theme from its parts and applies it:
--   spf/palette      -- raw hex, from xresources with fallbacks
--   spf/primitives   -- named styles built from the palette
--   spf/groups/*     -- semantic group -> primitive (or group) link maps
--
-- colors/spf.lua is a thin entry that calls apply(); all the data lives here.
-- See :help group-name / highlight-groups / diagnostic-highlights /
-- treesitter-highlight-groups / lsp-highlight.

local M = {}

-- Group sections, merged (in order) into one link map. Names match
-- spf/groups/<name>.lua.
local SECTIONS = { "syntax", "ui", "diagnostic", "lsp", "treesitter", "filetypes", "other" }

local function is_nonempty_table(x)
  return type(x) == "table" and next(x) ~= nil
end

-- Merge a section's group->target map into `links`. The old flat table let a
-- duplicate key silently win; warn instead so an accidental cross-section
-- redefinition is visible.
local function merge(links, section)
  for group, target in pairs(require("spf.groups." .. section)) do
    if links[group] ~= nil then
      vim.notify(string.format("spf: %q redefined in groups/%s", group, section), vim.log.levels.WARN)
    end
    links[group] = target
  end
end

--- Builds spf's source-of-truth tables without touching highlight state.
--- Returns { colors, highlights, links } -- the shape the specs inspect.
---@return { colors: table, highlights: table, links: table }
function M.build()
  local links = {}
  for _, section in ipairs(SECTIONS) do
    merge(links, section)
  end
  return {
    colors = require("spf.palette"),
    highlights = require("spf.primitives"),
    links = links,
  }
end

--- Applies the colorscheme: clears existing highlights, paints the primitives
--- and links, and sets the 16 terminal colors. Returns the built tables so
--- `:colorscheme spf` (which ignores the value) and tests share one path.
---@return { colors: table, highlights: table, links: table }
function M.apply()
  vim.cmd("highlight clear")
  vim.cmd("syntax reset")
  vim.g.colors_name = "spf"

  local theme = M.build()

  -- Concrete specs first, then links (links resolve lazily, so order between
  -- the two loops is not load-bearing).
  for group, keyset in pairs(theme.highlights) do
    if is_nonempty_table(keyset) then
      vim.api.nvim_set_hl(0, group, keyset)
    end
  end
  for group, link in pairs(theme.links) do
    if type(link) == "string" and link ~= "" then
      vim.api.nvim_set_hl(0, group, { link = link, default = false })
    end
  end

  local c = theme.colors
  vim.g.terminal_color_0 = c.black
  vim.g.terminal_color_1 = c.red
  vim.g.terminal_color_2 = c.green
  vim.g.terminal_color_3 = c.yellow
  vim.g.terminal_color_4 = c.blue
  vim.g.terminal_color_5 = c.magenta
  vim.g.terminal_color_6 = c.cyan
  vim.g.terminal_color_7 = c.white
  vim.g.terminal_color_8 = c.bright_black
  vim.g.terminal_color_9 = c.bright_red
  vim.g.terminal_color_10 = c.bright_green
  vim.g.terminal_color_11 = c.bright_yellow
  vim.g.terminal_color_12 = c.bright_blue
  vim.g.terminal_color_13 = c.bright_magenta
  vim.g.terminal_color_14 = c.bright_cyan
  vim.g.terminal_color_15 = c.bright_white

  return theme
end

return M
