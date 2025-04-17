return {
  {

    -- jackMort/ChatGPT.nvim uses `FoldColumn` to style the line on the left side of popup windows
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    keys = require("plugins.ai.keys"),
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTEditWithInstructions",
      "ChatGPTRun",
    },
    opts = function(_, opts)
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "ChatGPTTotalTokens", fg = nil, bg = c.brown, styles = {} },
        { name = "ChatGPTTotalTokensBorder", fg = c.brown, bg = nil, styles = {} },
      })

      local my_opts = {
        api_key_cmd = "pass show ai/openai/apikey",
        openai_params = {
          model = "gpt-4o",
        },
        popup_window = {
          border = {
            highlight = "FloatBorder",
            text = {
              top = "Chat-Gippity",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        system_window = {
          border = {
            highlight = "FloatBorder",
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        popup_input = {
          border = {
            highlight = "FloatBorder",
            text = {
              top = "",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        settings_window = {
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
      }
      return vim.tbl_deep_extend("force", opts or {}, my_opts)
    end,
  },

  ------------------------------------------------------------------------------
  -- Copilot
  ------------------------------------------------------------------------------

  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = false,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = "<M-y>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
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
        -- return false
        local icon = LazyVim.config.icons.kinds.Copilot
        local component = opts.sections.lualine_x[2]
        local content = type(component[1]) == "function" and component[1]() or component[1]
        if content == nil then
          return false
        end
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
