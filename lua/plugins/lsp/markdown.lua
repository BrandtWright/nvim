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
        -- Keep MarkdownCode here; do NOT link this to ColorColumn/CursorLine.
        -- The snacks picker preview sets a window-local winhighlight that remaps
        -- CursorLine -> Visual (snacks/picker/core/preview.lua). winhighlight
        -- follows link chains, so any target that resolves THROUGH the literal
        -- `CursorLine` group (e.g. spf's ColorColumn = "CursorLine") renders as
        -- Visual (nothing_on_visual) in the preview. markdownCode is a direct bg
        -- definition (nothing_on_cursorline) -- not named CursorLine -- so the
        -- remap doesn't touch it and code blocks render correctly in previews.
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
