return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      filetypes = {
        c = true,
        cpp = true,
        cs = true,
        markdown = true,
        help = true,
        lua = true,
        typescript = true,
        javascript = true,
        python = true,
        sql = true,
        terraform = true,
        haskell = true,
        gleam = true,
        rust = true,
      },
    },
  },
  {
    "nvim-cmp",
    opts = function(_, opts)
      for _, k in pairs(opts.sources) do
        if k.name == "copilot" then
          k.keyword_length = 5
        end
      end
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local can_find_copilot_component = function()
        local icon = LazyVim.config.icons.kinds.Copilot
        local component = opts.sections.lualine_x[2]
        local content = type(component[1]) == "function" and component[1]() or component[1]
        -- Copilot icon is a multi-byte character ( )
        if string.sub(content, 1, 2) ~= string.sub(icon, 1, 2) then
          vim.notify(
            "Could not find the Copilot component in Lualine.",
            vim.log.levels.WARN,
            { title = "Custom Copilot Config", icon = "⚠️" }
          )
          return false
        end
        return true
      end

      local modify_copilot_component = function()
        opts.sections.lualine_x[2].color = function()
          if not package.loaded["copilot"] then
            return
          end
          local colors = require("bw.config.colors")
          local status_colors = {
            [""] = { fg = colors.gold },
            ["Normal"] = { fg = colors.gold },
            ["Warning"] = { fg = colors.red },
            ["InProgress"] = { fg = colors.yellow },
          }
          local status = require("copilot.api").status.data
          return status_colors[status.status] or status_colors[""]
        end
      end

      if can_find_copilot_component() then
        modify_copilot_component()
      end
    end,
  },
}
