return {
  {

    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    keys = require("plugins.ai.keys"),
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTEditWithInstructions",
      "ChatGPTRun",
      "ChatGPTCompleteCode",
    },
    opts = function(_, opts)
      local my_opts = {
        api_key_cmd = "pass show ai/openai/apikey",
        openai_params = {
          model = "gpt-4o",
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
    lazy = true,
    event = nil,
    cmd = { "Copilot" },

    opts = {
      panel = { enabled = false },
      suggestion = {
        enabled = false,

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
        ["*"] = false,
        markdown = false,
      },
    },
    keys = {
      {
        "<leader>uo",
        "<cmd>Copilot! toggle<cr>",
        desc = "Toggle Copilot",
      },
    },
  },
}
