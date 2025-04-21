return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- TODO: Remove dependency on gruvbox
      local highlights = require("bw.util.highlights")
      local raisin_black = highlights.get_color("dark_panel", "bg")
      local white = highlights.get_color("white", "fg")
      local gruvbox_theme = require("lualine.themes.gruvbox_dark")
      local screen_glasses_theme = {
        normal = { c = { fg = white, bg = raisin_black } },
        insert = { c = { fg = white, bg = raisin_black } },
        visual = { c = { fg = white, bg = raisin_black } },
        replace = { c = { fg = white, bg = raisin_black } },
        command = { c = { fg = white, bg = raisin_black } },
        inactive = { c = { fg = white, bg = raisin_black } },
      }
      local theme = vim.tbl_deep_extend("force", gruvbox_theme, screen_glasses_theme)
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
