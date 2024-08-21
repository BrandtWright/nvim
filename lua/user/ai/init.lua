local c = require("bw.config.colors")
local highlights = require("bw.config.highlights")
highlights.register({
  { name = "ChatGPTTotalTokens", fg = nil, bg = c.brown, styles = {} },
  { name = "ChatGPTTotalTokensBorder", fg = c.brown, bg = nil, styles = {} },
})

return {

  ------------------------------------------------------------------------------
  -- ChatJippity
  ------------------------------------------------------------------------------

  {

    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    keys = {
      {
        "<leader>aa",
        function()
          vim.cmd("ChatGPT")
        end,
        desc = "Open",
      },
      {
        "<leader>ac",
        function()
          vim.cmd("ChatGPT")
        end,
        desc = "Open",
      },
      {
        "<leader>ad",
        function()
          vim.cmd("ChatGPTRun docstring")
        end,
        desc = "Doc String",
        mode = { "n", "x" },
      },
      {
        "<leader>ae",
        function()
          vim.cmd("ChatGPTRun explain_code")
        end,
        desc = "Explain Code",
        mode = { "n", "x" },
      },
      {
        "<leader>af",
        function()
          vim.cmd("ChatGPTRun fix_bugs")
        end,
        desc = "Fix Bugs",
        mode = { "n", "x" },
      },
      {
        "<leader>ag",
        function()
          vim.cmd("ChatGPTRun grammar_correction")
        end,
        desc = "Grammar Check",
        mode = { "n", "x" },
      },
      {
        "<leader>ai",
        function()
          vim.cmd("ChatGPTEditWithInstructions")
        end,
        desc = "Edit with Instructions",
        mode = { "n", "x" },
      },
      {
        "<leader>ak",
        function()
          vim.cmd("ChatGPTRun keywords")
        end,
        desc = "Keywords",
        mode = { "n", "x" },
      },
      {
        "<leader>ao",
        function()
          vim.cmd("ChatGPTRun optimize_code")
        end,
        desc = "Optimize Code",
        mode = { "n", "x" },
      },
      {
        "<leader>ar",
        function()
          vim.cmd("ChatGPTRun code_readability_analysis")
        end,
        desc = "Code Readability Analysis",
        mode = { "n", "x" },
      },
      {
        "<leader>aR",
        function()
          vim.cmd("ChatGPTRun roxygen_edit")
        end,
        desc = "Roxygen Edit",
        mode = { "n", "x" },
      },
      {
        "<leader>as",
        function()
          vim.cmd("ChatGPTRun summarize")
        end,
        desc = "Summarize",
        mode = { "n", "x" },
      },
      {
        "<leader>at",
        function()
          vim.cmd("ChatGPTRun add_tests")
        end,
        desc = "Add Tests",
        mode = { "n", "x" },
      },
    },
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTEditWithInstructions",
      "ChatGPTRun",
    },
    opts = {
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
    },
  },

  ------------------------------------------------------------------------------
  -- Copilot
  ------------------------------------------------------------------------------

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
