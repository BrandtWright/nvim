-------------------------------------------------------------------------------
-- SPF
--
-- A colorscheme for Neovim
--
-- TODO: implement `g:terminal_color_*` (see: https://tinyurl.com/y78ntvjk)

-- see: |highlihgt|
-- see: :edit $VIMRUNTIME/colors/README.txt
--
-- |highlight-groups| (Normal, Comment, etc.)
-- |group-name| (Keyword, Function, etc.)
-- |diagnostic-highlights| (DiagnosticError, DiagnosticWarn, etc)
-- |treesitter-highlight-groups| (@variable, @variable.builtin, etc)
-- |lsp-semantic-highlight| (@lsp.type.function, @lsp.type.variable.lua, etc)
-- |lsp-highlight| (LspReferenceText, LspReferenceRead, etc)
-------------------------------------------------------------------------------

local colors = {
  red = "#ff0000",
  yellow = "#ffff00",
  background = "#000000",
}

local highlights = {
  red = { fg = colors.red, bg = colors.background },
  yellow = { fg = colors.yellow, bg = colors.background },
}

local links = {
  Error = highlights.red,
  Exception = highlights.red,
  Warning = highlights.yellow,
}

local function map_links()
  -- Create a reverse lookup: keyset -> highlight name
  -- Note: each table is enumerated only once for constant-time lookups
  local reverse_highlights = {}
  for highlight_name, highlight_value in pairs(highlights) do
    -- Lua tables use reference equality:
    -- highlights.red == highlights.red is true
    -- So, the highlight_value table can be used as a key in reverse_highlights.
    if type(highlight_value) == "table" and next(highlight_value) ~= nil then
      reverse_highlights[highlight_value] = highlight_name
    end
  end

  local result = {}
  for link_name, highlight in pairs(links) do
    local highlight_name = reverse_highlights[highlight]
    if highlight_name then
      result[link_name] = highlight_name
    end
  end
  return result
end

-- Initialize an empty colorscheme
vim.cmd("highlight clear")
vim.cmd("syntax reset")
vim.g.colors_name = "spf"

-- Apply highlights
for k, v in pairs(highlights) do
  if type(v) == "table" and next(v) ~= nil then
    vim.api.nvim_set_hl(0, k, v)
  end
end

-- Apply links
for k, v in pairs(map_links()) do
  if type(v) == "string" then
    vim.api.nvim_set_hl(0, k, { link = v })
  end
end
