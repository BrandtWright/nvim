--------------------------------------------------------------------------------
-- Picker
--------------------------------------------------------------------------------
local picker = require("snacks").picker
return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- Higlights
      local apply_highlights = function()
        vim.cmd("hi! link SnacksPickerMatch Match")
        vim.cmd("hi! link SnacksPickerListCursorline PmenuSel")
      end
      apply_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("SnacksHighlights", { clear = true }),
        pattern = "*",
        callback = apply_highlights,
        desc = "Reapply snacks highlight groups after colorscheme changes",
      })

      local my_opts = {
        picker = {
          win = {
            input = {
              keys = {
                -- Override the default alt-h keymap for toggling hidden files
                -- so TMUX doesn't intercept the keymap
                ["<M-.>"] = "toggle_hidden",
                ["<M-h>"] = false,
              },
            },
          },
          formatters = {
            file = {
              filename_first = true,
            },
          },
          layouts = {
            vscode = {
              preview = false,
              layout = {
                backdrop = false,
                row = 1,
                width = 0.4,
                min_width = 80,
                height = 0.4,
                border = "none",
                box = "vertical",
                {
                  win = "input",
                  height = 1,
                  border = "rounded",
                  title = "{title} {live} {flags}",
                  title_pos = "center",
                },
                { win = "list", border = "single" },
                { win = "preview", title = "{preview}", border = "rounded" },
              },
            },
          },
        },
      }
      return vim.tbl_deep_extend("force", opts or {}, my_opts)
    end,
    keys = {
      { "<leader>lpa", picker.picker_actions, desc = "Actions" },
      { "<leader>lpf", picker.picker_format, desc = "Format" },
      { "<leader>lpl", picker.picker_layouts, desc = "Layouts" },
      { "<leader>lpp", picker.picker_preview, desc = "Preview" },
    },
  },
}
