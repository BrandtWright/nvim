return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.cmd("hi! link @text.literal.markdown_inline Function")
      vim.cmd("hi! link @markup.quote.markdown Normal")
      vim.cmd("hi! link @markup.raw.markdown_inline String")
      vim.cmd("hi! link @markup.heading.1.markdown MarkdownHeading1")
      vim.cmd("hi! link @markup.heading.2.markdown MarkdownHeading2")
      vim.cmd("hi! link @markup.heading.3.markdown MarkdownHeading3")
      vim.cmd("hi! link @markup.heading.4.markdown MarkdownHeading4")
      vim.cmd("hi! link @markup.heading.5.markdown MarkdownHeading5")
      vim.cmd("hi! link @markup.heading.6.markdown MarkdownHeading6")
      vim.cmd("hi! link @markup.link.markdown_inline HyperLink")
      vim.cmd("hi! link @markup.link.url.markdown_inline HyperLink")
      vim.cmd("hi! link @markup.link.label.markdown Normal")
      vim.cmd("hi! link @markup.link.label.markdown_inline HyperLink")
      vim.cmd("hi! link @markup.list.checked.markdown green")
      vim.cmd("hi! link @markup.list.unchecked.markdown red")
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = function(_, opts)
      vim.cmd("hi! link RenderMarkdownH1Bg MarkdownHeading1")
      vim.cmd("hi! link RenderMarkdownH2Bg MarkdownHeading2")
      vim.cmd("hi! link RenderMarkdownH3Bg MarkdownHeading3")
      vim.cmd("hi! link RenderMarkdownH4Bg MarkdownHeading4")
      vim.cmd("hi! link RenderMarkdownH5Bg MarkdownHeading5")
      vim.cmd("hi! link RenderMarkdownH6Bg MarkdownHeading6")
      vim.cmd("hi! link RenderMarkdownBullet Special")
      vim.cmd("hi! link RenderMarkdownChecked Type")
      vim.cmd("hi! link RenderMarkdownUnchecked Exception")
      vim.cmd("hi! link RenderMarkdownCode MarkdownCode")
      vim.cmd("hi! link RenderMarkdownTableHead FloatBorder")
      vim.cmd("hi! link RenderMarkdownTableRow FloatBorder")

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
