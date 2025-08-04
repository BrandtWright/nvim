-------------------------------------------------------------------------------
-- SPF
--
-- This file is part of the SPF color scheme for Neovim.
--
-- map colors to base palette spf highlights
-- define extended spf highlights
-- map builtins to spf highlights
-- map common to spf highlights
-------------------------------------------------------------------------------

local colors = {
  red = "#ff0000",
  blue = "#0000ff",
  background = "#000000",
}

local highlights = {
  red = { fg = colors.red, bg = colors.background },
  blue = { fg = colors.blue, bg = colors.background },
}

local links = {
  MyError = highlights.red,
  MyException = highlights.red,
  MyKeyword = highlights.blue,
}

local function map_builtins_to_theme_names()
  -- Create a reverse lookup: keyset -> highlight name This works because Lua
  -- tables use reference equality: highlight == highlights.highilght is true,
  -- and the table object can be used as a key in reverse_theme. Note: the
  -- keyset must be unique to the table so a sanity check is is needed to ensure
  -- that highlight is not overwrtten.
  local reverse_theme = {}
  local duplicate_highlights = {}
  for name, tbl in pairs(highlights) do
    reverse_theme[tbl] = name
  end
  -- Use the reverse lookup to map builtin keys to theme names
  local result = {}
  for builtin, theme_tbl in pairs(links) do
    local theme_name = reverse_theme[theme_tbl]
    if theme_name then
      result[builtin] = theme_name
    end
  end
  return result
end

vim.api.nvim_command("highlight clear")
vim.api.nvim_command("syntax reset")
vim.g.colors_name = "spf"

for k, v in pairs(highlights) do
  if v then
    vim.api.nvim_set_hl(0, k, v)
  end
end

local highlights = map_builtins_to_theme_names()
for k, v in pairs(highlights) do
  if v then
    vim.cmd("hi link " .. k .. " " .. v)
  end
end
