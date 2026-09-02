--------------------------------------------------------------------------------
-- Picker
--------------------------------------------------------------------------------
local highlights = require("bw.util.highlights")

return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- Highlights
      -- The snacks picker in spf's composite vocabulary (see colors.md "Panels &
      -- controls"): a `panel` (frame + titles) hosting a `textbox` (query), a
      -- `list` (results; selected item via `selection`), and a `view` (preview =
      -- content buffer). spf core stays plugin-agnostic; this wiring lives here.
      highlights.on_colorscheme("SnacksHighlights", function()
        vim.cmd("hi! link SnacksPickerMatch NormalFloat")
        -- controls: snacks chains every picker window NormalFloat -> SnacksPicker.
        vim.cmd("hi! link SnacksPicker list") -- results list
        vim.cmd("hi! link SnacksPickerListCursorline selection") -- selected item
        vim.cmd("hi! link SnacksPickerInput textbox") -- query field
        vim.cmd("hi! link SnacksPickerPreview Normal") -- view (content buffer)
        -- panel: solid frames + their titles, all on the panel band. snacks routes
        -- the box title's FloatTitle to the shared base `SnacksTitle` (the box
        -- winhighlight merge drops the picker prefix), the preview title to its own
        -- group; `SnacksTitle` is safe to paint -- the notifier and snacks-input
        -- use their own title groups, so only picker/scratch titles are affected.
        for _, g in ipairs({
          "SnacksPickerBoxBorder",
          "SnacksPickerPreviewBorder",
          "SnacksTitle",
          "SnacksPickerPreviewTitle",
        }) do
          vim.cmd("hi! link " .. g .. " panel")
        end
        -- ghost: muted secondary text (match count, dimmed dir, descriptions).
        -- snacks binds these to NonText *and* the syntax `Comment` group; route
        -- them to the UI `ghost` concept so picker chrome borrows no syntax color.
        -- (Visual no-op today -- all resolve to bright_black -- but now decoupled.)
        for _, g in ipairs({
          "SnacksPickerTotals",
          "SnacksPickerDir",
          "SnacksPickerPathHidden",
          "SnacksPickerComment",
          "SnacksPickerDesc",
        }) do
          vim.cmd("hi! link " .. g .. " ghost")
        end
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
            -- Flat, solid-border default: input+list share a solid surface frame
            -- (no inner divider line) so the input field reads as a distinct block
            -- above the list; the preview is a separate solid content block.
            default = {
              layout = {
                box = "horizontal",
                width = 0.8,
                min_width = 120,
                height = 0.8,
                {
                  box = "vertical",
                  border = "solid",
                  title = "{title} {live} {flags}",
                  title_pos = "center",
                  { win = "input", height = 1, border = "none" },
                  { win = "list", border = "none" },
                },
                { win = "preview", title = "{preview}", border = "solid", width = 0.5 },
              },
            },
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
      { "<leader>lpa", function() Snacks.picker.picker_actions() end, desc = "Actions" },
      { "<leader>lpf", function() Snacks.picker.picker_format() end, desc = "Format" },
      { "<leader>lpl", function() Snacks.picker.picker_layouts() end, desc = "Layouts" },
      { "<leader>lpp", function() Snacks.picker.picker_preview() end, desc = "Preview" },
    },
  },
}
