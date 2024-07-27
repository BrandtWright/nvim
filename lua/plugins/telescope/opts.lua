local set_telescope_highlights = function()
  local c = require("bw.config.colors")
  local highlights = require("bw.config.highlights")
  highlights.register({
    -- LineNr in current_buffer_fuzzy_find
    -- See: https://github.com/nvim-telescope/telescope.nvim/blob/master/plugin/telescope.lua
    { name = "TelescopeResultsSpecialComment", fg = c.brown, bg = c.terminal, styles = {} },
    { name = "TelescopeSelection", bg = c.cursor_line, styles = { "b" } },
    { name = "TelescopeSelectionCaret", fg = c.gold, bg = c.terminal, styles = { "b" } },
    { name = "TelescopeMatching", fg = c.white, bg = c.terminal, styles = { "b" } },
  })
end

return function()
  -- Some colorschemes set Telescope highlights. So, reapply telescope highlights
  -- when the colorscheme changes so that tele highlights are consistent.
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("TelescopeColorSchemeChangedHandler", { clear = true }),
    callback = set_telescope_highlights,
  })
  set_telescope_highlights()

  return {
    defaults = {
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
        width = 0.95,
        height = 0.85,
        prompt_position = "top",
      },

      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
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
