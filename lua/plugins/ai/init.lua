return {
  {

    ----------------------------------------------------------------------------
    -- Copilot
    ----------------------------------------------------------------------------

    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
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
    -- stylua: ignore
    keys = {
      { "<leader>aa", function() vim.cmd("ChatGPT") end, desc = "Open", },
      { "<leader>ac", function() vim.cmd("ChatGPT") end, desc = "Open", },
      { "<leader>ad", function() vim.cmd("ChatGPTRun docstring") end, desc = "Doc String", mode = { "n", "x" }, },
      { "<leader>ae", function() vim.cmd("ChatGPTRun explain_code") end, desc = "Explain Code", mode = { "n", "x" }, },
      { "<leader>af", function() vim.cmd("ChatGPTRun fix_bugs") end, desc = "Fix Bugs", mode = { "n", "x" }, },
      { "<leader>ag", function() vim.cmd("ChatGPTRun grammar_correction") end, desc = "Grammar Check", mode = { "n", "x" }, },
      { "<leader>ai", function() vim.cmd("ChatGPTEditWithInstructions") end, desc = "Edit with Instructions", mode = { "n", "x" }, },
      { "<leader>ak", function() vim.cmd("ChatGPTRun keywords") end, desc = "Keywords", mode = { "n", "x" }, },
      { "<leader>ao", function() vim.cmd("ChatGPTRun optimize_code") end, desc = "Optimize Code", mode = { "n", "x" }, },
      { "<leader>ar", function() vim.cmd("ChatGPTRun code_readability_analysis") end, desc = "Code Readability Analysis", mode = { "n", "x" }, },
      { "<leader>aR", function() vim.cmd("ChatGPTRun roxygen_edit") end, desc = "Roxygen Edit", mode = { "n", "x" }, },
      { "<leader>as", function() vim.cmd("ChatGPTRun summarize") end, desc = "Summarize", mode = { "n", "x" }, },
      { "<leader>at", function() vim.cmd("ChatGPTRun add_tests") end, desc = "Add Tests", mode = { "n", "x" }, },
    },
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
