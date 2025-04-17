return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      vim.cmd("hi! link LuaLineDiffAdd DiffAdd")
      vim.cmd("hi! link LuaLineDiffChange DiffChange")
      vim.cmd("hi! link LuaLineDiffDelete DiffDelete")

      -- TODO: Use highlights instead
      local theme = require("lualine.themes.gruvbox_dark")
      local c = require("bw.config.colors")
      theme.normal.c.fg = c.white
      theme.normal.c.bg = c.raisin_black
      theme.insert.c.fg = c.white
      theme.insert.c.bg = c.raisin_black
      theme.visual.c.fg = c.white
      theme.visual.c.bg = c.raisin_black
      theme.replace.c.fg = c.white
      theme.replace.c.bg = c.raisin_black
      theme.command.c.fg = c.white
      theme.command.c.bg = c.raisin_black
      theme.inactive.c.fg = c.white
      theme.inactive.c.bg = c.raisin_black

      opts.options.theme = theme
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }

      -- Lualine X
      local has_updates_condition = require("lazy.status").has_updates
      for _, v in pairs(opts.sections.lualine_x) do
        -- Lazy Update Indicator Component
        if v.cond == has_updates_condition then
          v.color = { fg = c.gold }
        end
      end
    end,
  },
}
