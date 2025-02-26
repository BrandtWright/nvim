local c = require("bw.config.colors")
return {
  { name = "@text.literal.markdown_inline", fg = c.yellow, bg = c.terminal, styles = {} },
  { name = "@markup.quote.markdown", fg = c.white, bg = c.terminal, styles = { "i" } },
  -- Lsp Hover Floating Window Uses this:
  { name = "@punctuation.special.markdown", fg = c.brown, bg = nil, styles = {} },
  { name = "@markup.list.markdown", fg = c.gold, bg = nil, styles = {} },
  { name = "@markup.heading.1.markdown", bg = c.terminal, fg = "#998568", styles = { "b" } },
  { name = "@markup.heading.2.markdown", bg = c.terminal, fg = "#8c7a5f", styles = { "b" } },
  { name = "@markup.heading.3.markdown", bg = c.terminal, fg = "#806f57", styles = { "b" } },
  { name = "@markup.heading.4.markdown", bg = c.terminal, fg = "#73644e", styles = { "b" } },
  { name = "@markup.heading.5.markdown", bg = c.terminal, fg = "#665945", styles = { "b" } },
  { name = "@markup.heading.6.markdown", bg = c.terminal, fg = "#594e3d", styles = { "b" } },
  { name = "@markup.link.markdown_inline", fg = c.bright_blue, bg = nil, styles = { "u" } },
  { name = "@markup.link.url.markdown_inline", fg = c.bright_blue, bg = nil, styles = { "u" } },
  { name = "@markup.link.label.markdown_inline", fg = c.bright_blue, styles = {} },
  { name = "@markup.list.checked.markdown", fg = c.gold, styles = {} },
  { name = "@markup.list.unchecked.markdown", fg = c.gold, styles = {} },
}
