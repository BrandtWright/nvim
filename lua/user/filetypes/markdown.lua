local c = require("bw.config.colors")
local highlights = require("bw.config.highlights")
highlights.register({
  { name = "RenderMarkdownH1Bg", bg = c.terminal, fg = "#998568", styles = { "b" } },
  { name = "RenderMarkdownH2Bg", bg = c.terminal, fg = "#8c7a5f", styles = { "b" } },
  { name = "RenderMarkdownH3Bg", bg = c.terminal, fg = "#806f57", styles = { "b" } },
  { name = "RenderMarkdownH4Bg", bg = c.terminal, fg = "#73644e", styles = { "b" } },
  { name = "RenderMarkdownH5Bg", bg = c.terminal, fg = "#665945", styles = { "b" } },
  { name = "RenderMarkdownH6Bg", bg = c.terminal, fg = "#594e3d", styles = { "b" } },
  { name = "RenderMarkdownBullet", fg = c.gold, bg = c.terminal },
  { name = "RenderMarkdownChecked", fg = c.green, styles = {} },
  { name = "RenderMarkdownUnchecked", fg = c.red, styles = {} },
  { name = "@markup.list.checked.markdown", fg = c.gold, styles = {} },
  { name = "@markup.list.unchecked.markdown", fg = c.gold, styles = {} },
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
