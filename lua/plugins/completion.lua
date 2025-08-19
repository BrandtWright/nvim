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
      local function apply_highlights()
        vim.cmd("hi! link BlinkCmpKind DiagnosticInfo")
        vim.cmd("hi! link BlinkCmpDoc Normal")
        vim.cmd("hi! link BlinkCmpDocSeparator WinSeparator")
        vim.cmd("hi! link BlinkCmpDocBorder FloatBorder")
        vim.cmd("hi! link BlinkCmpMenuBorder FloatBorder")
      end

      apply_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("BlinkCmpHighlights", { clear = true }),
        pattern = "*",
        callback = apply_highlights,
        desc = "Reapply blink.cmp highlight groups after colorscheme changes",
      })

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
