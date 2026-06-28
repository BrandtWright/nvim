--------------------------------------------------------------------------------
-- Picker
--------------------------------------------------------------------------------
local highlights = require("bw.util.highlights")

return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- Highlights
      highlights.on_colorscheme("SnacksHighlights", function()
        vim.cmd("hi! link SnacksPickerMatch NormalFloat")
        vim.cmd("hi! link SnacksPickerListCursorline PmenuSel")
      end)

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
    -- stylua: ignore
    keys = {
      { "<leader>lpa", function() require("snacks").picker.picker_actions() end, desc = "Actions" },
      { "<leader>lpf", function() require("snacks").picker.picker_format() end, desc = "Format" },
      { "<leader>lpl", function() require("snacks").picker.picker_layouts() end, desc = "Layouts" },
      { "<leader>lpp", function() require("snacks").picker.picker_preview() end, desc = "Preview" },
    },
  },
}
