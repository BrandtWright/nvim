return function()
  -- TelescopeResultsSpecialComment: LineNr in current_buffer_fuzzy_find
  -- See: https://github.com/nvim-telescope/telescope.nvim/blob/master/plugin/telescope.lua
  vim.cmd("hi! link TelescopeResultsSpecialComment NonText")
  vim.cmd("hi! link TelescopeSelectionCaret Red")
  vim.cmd("hi! link TelescopeSelection Cursorline")
  vim.cmd("hi! link TelescopeMatching Match")
  -- This appears to be broken and doesn't acually highlight anything.
  -- Watch: https://github.com/nvim-telescope/telescope.nvim/issues/3441
  vim.cmd("hi! link TelescopePreviewMatch Match")
  vim.cmd("hi! link TelescopePreviewBorder Border")
  vim.cmd("hi! link TelescopePromptBorder Border")
  vim.cmd("hi! link TelescopeResultsBorder Border")

  return {
    defaults = {
      path_display = { "filename_first" },
      prompt_prefix = "❯ ",
      selection_caret = "❯ ",
      preview = {
        telescope = true,
      },

      winblend = 0,
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      scroll_strategy = "cycle",
      color_devicons = true,

      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

      layout_config = {
        width = 0.80,
        height = 0.80,
        prompt_position = "top",
        horizontal = {
          results_width = 0.4,
          preview_width = 0.6,
        },
      },

      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },

    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case" (default: "smart_case")
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({
          -- even more opts
        }),
      },
      notify = {},
      emoji = {},
      file_browser = {},
      project = {
        theme = "dropdown",
        search_by = "title",
        on_project_selected = function(prompt_bufnr)
          local project_actions = require("telescope._extensions.project.actions")
          project_actions.change_working_directory(prompt_bufnr, false)
        end,
      },
    },
  }
end
