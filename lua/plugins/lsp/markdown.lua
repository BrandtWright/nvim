return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = function(_, opts)
      local apply_highlights = function()
        vim.cmd("hi! link RenderMarkdownH1Bg markdownH1")
        vim.cmd("hi! link RenderMarkdownH2Bg markdownH2")
        vim.cmd("hi! link RenderMarkdownH3Bg markdownH3")
        vim.cmd("hi! link RenderMarkdownH4Bg markdownH4")
        vim.cmd("hi! link RenderMarkdownH5Bg markdownH5")
        vim.cmd("hi! link RenderMarkdownH6Bg markdownH6")
        vim.cmd("hi! link RenderMarkdownQuote1 Special")
        vim.cmd("hi! link RenderMarkdownQuote2 RenderMarkdownQuote1")
        vim.cmd("hi! link RenderMarkdownQuote3 RenderMarkdownQuote1")
        vim.cmd("hi! link RenderMarkdownQuote4 RenderMarkdownQuote1")
        vim.cmd("hi! link RenderMarkdownQuote5 RenderMarkdownQuote1")
        vim.cmd("hi! link RenderMarkdownQuote6 RenderMarkdownQuote1")
        vim.cmd("hi! link RenderMarkdownCode MarkdownCode")
        vim.cmd("hi! link RenderMarkdownTableHead FloatBorder")
        vim.cmd("hi! link RenderMarkdownTableRow FloatBorder")
        vim.cmd("hi! link RenderMarkdownBullet markdownListMarker")
      end

      apply_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("RenderMarkdownHighlights", { clear = true }),
        pattern = "*",
        callback = apply_highlights,
        desc = "Reapply render-markdown highlight groups after colorscheme changes",
      })

      local my_opts = {
        link = {
          custom = {
            web = {
              icon = "",
            },
          },
        },
        checkbox = {
          enabled = true,
        },
      }

      return vim.tbl_deep_extend("force", opts or {}, my_opts)
    end,
  },
}
