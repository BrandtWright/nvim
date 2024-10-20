local c = require("bw.config.colors")
local highlights = require("bw.config.highlights")
highlights.register({
  { name = "RenderMarkdownH1Bg", fg = c.terminal, bg = c.yellow, styles = { "b" } },
  { name = "RenderMarkdownH2Bg", fg = c.terminal, bg = c.gold, styles = { "b" } },
  { name = "RenderMarkdownH3Bg", fg = c.terminal, bg = c.orange, styles = { "b" } },
  { name = "RenderMarkdownH4Bg", fg = c.terminal, bg = c.red, styles = { "b" } },
  { name = "RenderMarkdownH5Bg", fg = c.terminal, bg = c.dark_red, styles = { "b" } },
  { name = "RenderMarkdownH6Bg", fg = c.terminal, bg = c.brown, styles = { "b" } },
  { name = "RenderMarkdownBullet", fg = c.gold, bg = c.terminal },
  { name = "RenderMarkdownChecked", fg = c.green, styles = {} },
  { name = "RenderMarkdownUnchecked", fg = c.red, styles = {} },
})

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      link = {
        custom = {
          web = {
            icon = "",
          },
        },
      },
    },
  },
}
