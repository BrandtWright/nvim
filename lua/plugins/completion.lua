return {
  {
    "LazyVim/LazyVim",
    opts = {
      icons = {
        kinds = {
          Snippet = "Տ ",
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "BlinkCmpKind", bg = c.terminal, fg = c.gold },
        { name = "BlinkCmpDoc", bg = c.terminal },
        { name = "BlinkCmpDocSeparator", bg = c.terminal, fg = c.gold },
        { name = "BlinkCmpDocBorder", bg = c.terminal, fg = c.gold },
        { name = "BlinkCmpMenuBorder", bg = c.terminal, fg = c.gold },
      })

      local my_opts = {
        completion = {
          menu = { border = "single" },
          documentation = { window = { border = "single" } },
        },
        signature = { window = { border = "single" } },
      }
      return vim.tbl_deep_extend("force", opts or {}, my_opts)
    end,
  },
}
