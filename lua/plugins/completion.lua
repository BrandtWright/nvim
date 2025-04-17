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
      vim.cmd("hi! link BlinkCmpKind Special")
      vim.cmd("hi! link BlinkCmpDoc Normal")
      vim.cmd("hi! link BlinkCmpDocSeparator Special")
      vim.cmd("hi! link BlinkCmpDocBorder Special")
      vim.cmd("hi! link BlinkCmpMenuBorder Special")

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
