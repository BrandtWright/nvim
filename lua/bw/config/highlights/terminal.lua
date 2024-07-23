local highlights = function()
  local c = require("bw.config.colors")
  vim.g.terminal_color_0 = c.black -- black
  vim.g.terminal_color_1 = c.red -- red
  vim.g.terminal_color_2 = c.green -- green
  vim.g.terminal_color_3 = c.yellow -- yellow
  vim.g.terminal_color_4 = c.blue -- blue
  vim.g.terminal_color_5 = c.magenta -- magenta
  vim.g.terminal_color_6 = c.cyan -- cyan
  vim.g.terminal_color_7 = c.white -- white

  vim.g.terminal_color_8 = c.bright_black -- black
  vim.g.terminal_color_9 = c.bright_red -- red
  vim.g.terminal_color_10 = c.bright_green -- green
  vim.g.terminal_color_11 = c.bright_yellow -- yellow
  vim.g.terminal_color_12 = c.bright_blue -- blue
  vim.g.terminal_color_13 = c.bright_magenta -- magenta
  vim.g.terminal_color_14 = c.bright_cyan -- cyan
  vim.g.terminal_color_15 = c.bright_white -- white

  return {

    { name = "TermCursor", fg = c.terminal, bg = c.white, styles = {} },
    { name = "TermCursorNC", fg = c.terminal, bg = c.white, styles = {} },
  }
end

return highlights()
