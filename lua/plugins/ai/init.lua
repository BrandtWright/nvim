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
      vim.cmd("hi! link ChatGPTTotalTokens brown_inverse")
      vim.cmd("hi! link ChatGPTTotalTokensBorder brown")

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
}
