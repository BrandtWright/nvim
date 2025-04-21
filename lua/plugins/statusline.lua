return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local hl = require("bw.util.highlights").get_color
      local screen_glasses_theme = {
        normal = {
          a = { fg = hl("Normal", "bg"), bg = hl("bright_panel", "bg") },
          b = { fg = hl("panel", "fg"), bg = hl("panel", "bg") },
          c = { fg = hl("dark_panel", "fg"), bg = hl("dark_panel", "bg") },
        },
        insert = {
          a = { fg = hl("Normal", "bg"), bg = hl("green", "fg") },
          b = { fg = hl("panel", "fg"), bg = hl("panel", "bg") },
          c = { fg = hl("dark_panel", "fg"), bg = hl("dark_panel", "bg") },
        },
        visual = {
          a = { fg = hl("Normal", "bg"), bg = hl("blue", "fg") },
          b = { fg = hl("panel", "fg"), bg = hl("panel", "bg") },
          c = { fg = hl("dark_panel", "fg"), bg = hl("dark_panel", "bg") },
        },
        replace = {
          a = { fg = hl("Normal", "bg"), bg = hl("red", "fg") },
          b = { fg = hl("panel", "fg"), bg = hl("panel", "bg") },
          c = { fg = hl("dark_panel", "fg"), bg = hl("dark_panel", "bg") },
        },
        command = {
          a = { fg = hl("Normal", "bg"), bg = hl("yellow", "fg") },
          b = { fg = hl("panel", "fg"), bg = hl("panel", "bg") },
          c = { fg = hl("dark_panel", "fg"), bg = hl("dark_panel", "bg") },
        },
        inactive = {
          a = { fg = hl("dark_panel", "fg"), bg = hl("dark_panel", "bg") },
          b = { fg = hl("panel", "fg"), bg = hl("panel", "bg") },
          c = { fg = hl("dark_panel", "fg"), bg = hl("dark_panel", "bg") },
        },
      }
      opts.options.theme = screen_glasses_theme
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
    end,
  },
}
