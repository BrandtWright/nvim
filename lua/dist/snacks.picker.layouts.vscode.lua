--------------------------------------------------------------------------------
-- VS Code Style Layout for Snacks.nvim
--------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        formatters = {
          file = {
            filename_first = true,
          },
        },
        layouts = {
          vscode = {
            -- preview = false,
            layout = {
              backdrop = false,
              row = 1,
              width = 0.4,
              min_width = 80,
              height = 0.4,
              border = "none",
              box = "vertical",
              { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
              { win = "list", border = "single" },
              { win = "preview", title = "{preview}", border = "rounded" },
            },
          },
        },
      },
    },
  },
}
