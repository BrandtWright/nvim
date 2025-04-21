return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- TODO: Build up theme from screen_glasses, not gruvbox...
      local get_color = require("bw.util.highlights").get_color
      local raisin_black = get_color("dark_panel", "bg")
      local white = get_color("white", "fg")
      local theme = require("lualine.themes.gruvbox_dark")
      theme.normal.c.fg = white
      theme.normal.c.bg = raisin_black
      theme.insert.c.fg = white
      theme.insert.c.bg = raisin_black
      theme.visual.c.fg = white
      theme.visual.c.bg = raisin_black
      theme.replace.c.fg = white
      theme.replace.c.bg = raisin_black
      theme.command.c.fg = white
      theme.command.c.bg = raisin_black
      theme.inactive.c.fg = white
      theme.inactive.c.bg = raisin_black
      opts.options.theme = theme
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
    end,
  },
}
