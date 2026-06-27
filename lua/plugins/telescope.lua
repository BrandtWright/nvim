return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-lua/plenary.nvim",
    },
    opts = function()
      local apply_highlights = function()
        -- TelescopeResultsSpecialComment: LineNr in current_buffer_fuzzy_find
        -- See: https://github.com/nvim-telescope/telescope.nvim/blob/master/plugin/telescope.lua
        vim.cmd("hi! link TelescopeResultsSpecialComment NonText")
        vim.cmd("hi! link TelescopeSelectionCaret Red")
        vim.cmd("hi! link TelescopeSelection PmenuSel")
        vim.cmd("hi! link TelescopeMatching Match")
        -- This appears to be broken and doesn't acually highlight anything.
        -- Watch: https://github.com/nvim-telescope/telescope.nvim/issues/3441
        vim.cmd("hi! link TelescopePreviewMatch Match")
        vim.cmd("hi! link TelescopePreviewBorder FloatBorder")
        vim.cmd("hi! link TelescopePromptBorder FloatBorder")
        vim.cmd("hi! link TelescopeResultsBorder FloatBorder")
        vim.cmd("hi! link TelescopeMultiSelection bright_green")
      end

      apply_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("TelescopeHighlights", { clear = true }),
        pattern = "*",
        callback = apply_highlights,
        desc = "Reapply telescope highlight groups after colorscheme changes",
      })

      return {
        defaults = {
          path_display = { "filename_first" },
          prompt_prefix = " ",
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
        },

        extensions = {
          -- project is auto-loaded on access by <leader>fp (see config/keymaps.lua).
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
    end,
  },
}
