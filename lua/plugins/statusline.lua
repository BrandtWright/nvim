return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = not vim.env.NO_LUALINE,
    opts = function(_, opts)
      local hl = require("bw.util.highlights").get_attribute

      -- Colors
      local red = hl("DiagnosticError", "fg")
      local green = hl("DiagnosticOk", "fg")
      local yellow = hl("DiagnosticWarn", "fg")
      local blue = hl("DiagnosticInfo", "fg")
      local black = hl("Normal", "bg")

      -- Lualine C
      local dark_highlight = { fg = hl("StatusLine", "fg"), bg = hl("StatusLine", "bg") }

      -- Lualine B
      local medium_highlight = { fg = hl("StatusLineNC", "fg"), bg = hl("StatusLineNC", "bg") }

      -- Lualine A
      local light_highlight = { fg = hl("StatusLineTerm", "fg"), bg = hl("StatusLineTerm", "bg") }

      local insert_highlight = { fg = black, bg = green }
      local replace_highlight = { fg = black, bg = red }
      local visual_highlight = { fg = black, bg = blue }
      local command_highlight = { fg = black, bg = yellow }
      local inactive_highlight = { fg = dark_highlight.bg, bg = dark_highlight.bg }

      local screen_glasses_theme = {
        normal = { a = light_highlight, b = medium_highlight, c = dark_highlight },
        insert = { a = insert_highlight, b = medium_highlight, c = dark_highlight },
        visual = { a = visual_highlight, b = medium_highlight, c = dark_highlight },
        replace = { a = replace_highlight, b = medium_highlight, c = dark_highlight },
        command = { a = command_highlight, b = medium_highlight, c = dark_highlight },
        inactive = { a = inactive_highlight, b = medium_highlight, c = dark_highlight },
      }

      -- Remove the diff secion from section x (I put this in section y)
      local lazy_x = opts.sections.lualine_x or {}
      local diff_component = {}
      for i, v in ipairs(lazy_x) do
        if v[1] == "diff" then
          diff_component = v
          table.remove(lazy_x, i)
        end
      end

      local my_opts = {
        sections = {
          lualine_y = { diff_component },
          lualine_z = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
        },
        options = {
          theme = screen_glasses_theme,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
      }
      return vim.tbl_deep_extend("force", opts or {}, my_opts)
    end,
  },
}
