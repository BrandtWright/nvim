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
      local primary_accent = hl("WinBar", "bg")
      local secondary_accent = hl("WinBarNC", "bg")
      local tertiary_accent = hl("WinBar", "fg")

      -- Lualine C (all modes)
      local dark_highlight = { fg = tertiary_accent, bg = primary_accent }

      -- Lualine B (all modes)
      local medium_highlight = { fg = tertiary_accent, bg = secondary_accent }

      -- Lualine A (by bode)
      local normal_highlight = { fg = primary_accent, bg = tertiary_accent }
      local insert_highlight = { fg = black, bg = green }
      local replace_highlight = { fg = black, bg = red }
      local visual_highlight = { fg = black, bg = blue }
      local command_highlight = { fg = black, bg = yellow }
      local inactive_highlight = { fg = primary_accent, bg = primary_accent }

      local screen_glasses_theme = {
        normal = { a = normal_highlight, b = medium_highlight, c = dark_highlight },
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
