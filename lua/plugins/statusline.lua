return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = not vim.env.NO_LUALINE,
    opts = function(_, opts)
      local load = require("bw.util.xresources").load
      local prefix = "screen_glasses.ui."
      local background = load("background") or "#171717"

      local dark_highlight = {
        fg = load(prefix .. "color7") or "#ebdbb2",
        bg = load(prefix .. "primary_accent") or "#171717",
      }

      local medium_highlight = {
        fg = load(prefix .. "color7") or "#ebdbb2",
        bg = load(prefix .. "secondary_accent") or "#4f4945",
      }

      local bright_highlight = {
        fg = load(prefix .. "color0") or "#171717",
        bg = load(prefix .. "tertiary_accent") or "#a89984",
      }

      local inactive_highlight = {
        fg = dark_highlight.bg,
        bg = dark_highlight.bg,
      }

      local replace_highlight = {
        fg = background,
        bg = load("color1") or "#bd7671",
      }

      local insert_highlight = {
        fg = background,
        bg = load("color2") or "#8fa899",
      }

      local command_highlight = {
        fg = background,
        bg = load("color3") or "#c2c27c",
      }

      local visual_highlight = {
        fg = background,
        bg = load("color4") or "#5692db",
      }

      local screen_glasses_theme = {
        normal = {
          a = bright_highlight,
          b = medium_highlight,
          c = dark_highlight,
        },
        insert = {
          a = insert_highlight,
          b = medium_highlight,
          c = dark_highlight,
        },
        visual = {
          a = visual_highlight,
          b = medium_highlight,
          c = dark_highlight,
        },
        replace = {
          a = replace_highlight,
          b = medium_highlight,
          c = dark_highlight,
        },
        command = {
          a = command_highlight,
          b = medium_highlight,
          c = dark_highlight,
        },
        inactive = {
          a = inactive_highlight,
          b = medium_highlight,
          c = dark_highlight,
        },
      }
      opts.options.theme = screen_glasses_theme
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
    end,
  },
}
