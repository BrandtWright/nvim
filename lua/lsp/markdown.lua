return {
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
