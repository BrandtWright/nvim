local c = require("bw.config.colors")
local highlights = require("bw.config.highlights")
highlights.register({
  { name = "RenderMarkdownH1Bg", fg = c.terminal, bg = c.dark_red, styles = { "b" } },
  { name = "RenderMarkdownH2Bg", fg = c.terminal, bg = c.dark_orange, styles = { "b" } },
  { name = "RenderMarkdownH3Bg", fg = c.terminal, bg = c.gold, styles = { "b" } },
  { name = "RenderMarkdownH4Bg", fg = c.terminal, bg = c.purple, styles = { "b" } },
  { name = "RenderMarkdownH5Bg", fg = c.terminal, bg = c.blue, styles = { "b" } },
  { name = "RenderMarkdownH5Bg", fg = c.terminal, bg = c.cyan, styles = { "b" } },
  { name = "RenderMarkdownBullet", fg = c.gold, bg = c.terminal },
  { name = "RenderMarkdownChecked", fg = c.green, styles = {} },
  { name = "RenderMarkdownUnchecked", fg = c.red, styles = {} },
})
return {
  {
    "MeanderingProgrammer/markdown.nvim",
    opts = {
      file_types = { "markdown", "norg", "rmd", "org" },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
    },
    ft = { "markdown", "norg", "rmd", "org" },
  },
}
