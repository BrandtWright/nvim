local c = require("bw.config.colors")
return {
  { name = "@text.literal.markdown_inline", fg = c.yellow, bg = c.terminal, styles = {} },
  { name = "@markup.link.label.markdown_inline", fg = c.red, bg = c.terminal, styles = {} },
  { name = "@markup.quote.markdown", fg = c.white, bg = c.terminal, styles = { "i" } },
  -- Lsp Hover Floating Window Uses this:
  { name = "@punctuation.special.markdown", fg = c.brown, bg = nil, styles = {} },
  { name = "@markup.list.markdown", fg = c.gold, bg = nil, styles = {} },
  { name = "@markup.heading.1.markdown", fg = c.dark_red, bg = nil, styles = {} },
  { name = "@markup.heading.2.markdown", fg = c.dark_orange, bg = nil, styles = {} },
  { name = "@markup.heading.3.markdown", fg = c.gold, bg = nil, styles = {} },
  { name = "@markup.link.markdown_inline", fg = c.cyan, bg = nil, styles = { "u" } },
  { name = "@markup.link.url.markdown_inline", fg = c.cyan, bg = nil, styles = { "u" } },
  { name = "@markup.link.label.markdown_inline", fg = c.cyan, styles = {} },
}

