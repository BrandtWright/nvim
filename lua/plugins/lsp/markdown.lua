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
        -- render-markdown renders inside the snacks picker preview, and that
        -- preview RESERVES a set of highlight groups: it remaps them window-locally
        -- via winhighlight (see snacks/picker/core/preview.lua). The reserved
        -- groups are: NormalFloat, FloatBorder, FloatTitle, FloatFooter, and
        -- CursorLine (-> Visual). winhighlight follows link chains, so any
        -- RenderMarkdown* group that resolves THROUGH one of those names will pick
        -- up the preview's remapped color instead of the intended one.
        --
        -- => When choosing a link target for anything that can appear in a preview,
        --    make sure it does not resolve (directly or via links) to a reserved
        --    group. ColorColumn is a standard, safe target for the code background.
        vim.cmd("hi! link RenderMarkdownCode ColorColumn")
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
        math = { enabled = true },
        code = {
          right_pad = 2,
          left_pad = 2,
        },
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
