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
      vim.cmd("hi! link BlinkCmpKind bright_cyan")
      vim.cmd("hi! link BlinkCmpDoc Normal")
      vim.cmd("hi! link BlinkCmpDocSeparator WinSeparator")
      vim.cmd("hi! link BlinkCmpDocBorder FloatBorder")
      vim.cmd("hi! link BlinkCmpMenuBorder FloatBorder")

      local my_opts = {
        completion = {
          menu = { border = "single" },
          documentation = { window = { border = "single" } },
        },
        signature = {
          enabled = true,
          window = { border = "single" },
        },
      }
      return vim.tbl_deep_extend("force", opts or {}, my_opts)
    end,
  },
}
