local c = require("bw.config.colors")
local highlights = require("bw.config.highlights")
highlights.register({
  { name = "RenderMarkdownH1Bg", fg = c.terminal, bg = "#998568", styles = { "b" } },
  { name = "RenderMarkdownH2Bg", fg = c.terminal, bg = "#8c7a5f", styles = { "b" } },
  { name = "RenderMarkdownH3Bg", fg = c.terminal, bg = "#806f57", styles = { "b" } },
  { name = "RenderMarkdownH4Bg", fg = c.terminal, bg = "#73644e", styles = { "b" } },
  { name = "RenderMarkdownH5Bg", fg = c.terminal, bg = "#665945", styles = { "b" } },
  { name = "RenderMarkdownH6Bg", fg = c.terminal, bg = "#594e3d", styles = { "b" } },
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
