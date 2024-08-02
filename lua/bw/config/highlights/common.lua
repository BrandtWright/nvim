local c = require("bw.config.colors")
return {
  { name = "Normal", fg = c.white, bg = c.terminal, styles = {} },
  { name = "String", fg = c.orange, bg = nil, styles = {} },
  { name = "Comment", fg = c.comment, bg = nil, styles = { "i" } },
  { name = "Special", fg = c.gold, bg = c.terminal, styles = {} },
  { name = "Statement", fg = c.gold, bg = c.terminal, styles = {} },

  ------------------------------------------------------------------------------
  -- Comment
  ------------------------------------------------------------------------------
  -- Treesitter
  { name = "@comment", fg = c.comment, bg = nil, styles = { "i" } },
  -- Semantic Tokens
  { name = "@lsp.type.comment", fg = c.comment, bg = nil, styles = { "i" } },

  ------------------------------------------------------------------------------
  -- Function
  ------------------------------------------------------------------------------
  -- Treesitter
  { name = "@function", fg = c.yellow, bg = nil, styles = {} },
  { name = "@function.call", fg = c.yellow, bg = nil, styles = { "i" } },
  { name = "@function.builtin", fg = c.gold, bg = nil, styles = {} },
  { name = "@constant.builtin", fg = c.gold, bg = nil, styles = { "i" } },
  -- Semantic Tokens
  { name = "@lsp.type.function", fg = c.yellow, bg = nil, styles = {} },
  { name = "@lsp.typemod.function.", fg = c.gold, bg = nil, styles = {} },

  ------------------------------------------------------------------------------
  -- Method
  ------------------------------------------------------------------------------
  -- Treesitter
  { name = "@method", fg = c.yellow, bg = nil, styles = {} },
  { name = "@method.call", fg = c.yellow, bg = nil, styles = { "i" } },
  -- Semantic Tokens
  { name = "@lsp.type.method", fg = c.yellow, bg = nil, styles = {} },

  ------------------------------------------------------------------------------
  -- Property
  ------------------------------------------------------------------------------
  -- Treesitter
  { name = "@property", fg = c.green, bg = nil, styles = {} },
  -- Semantic Tokens
  { name = "@lsp.type.property", fg = c.green, bg = nil, styles = {} },

  ------------------------------------------------------------------------------
  -- Variable
  ------------------------------------------------------------------------------
  -- Semantic Tokens
  { name = "@lsp.type.variable", fg = c.white, bg = nil, styles = {} },

  ------------------------------------------------------------------------------
  -- Type
  ------------------------------------------------------------------------------
  -- Treesitter
  { name = "@Type", fg = c.bright_green, bg = nil, styles = {} },

  ------------------------------------------------------------------------------
  -- Keyword
  ------------------------------------------------------------------------------
  { name = "Keyword", fg = c.blue, bg = nil, styles = {} },
  -- Treesitter
  { name = "@keyword", fg = c.blue, bg = nil, styles = {} },
  { name = "@keyword.function", fg = c.blue, bg = nil, styles = {} },
  { name = "@keyword.return", fg = c.blue, bg = nil, styles = {} },

  ------------------------------------------------------------------------------
  -- Conditional
  ------------------------------------------------------------------------------
  -- Treesitter
  { name = "@conditional", fg = c.purple, bg = nil, styles = {} },
  { name = "@keyword.conditional", fg = c.purple, bg = nil, styles = {} },

  ------------------------------------------------------------------------------
  -- Loops
  ------------------------------------------------------------------------------
  -- Treesitter
  { name = "@repeat", fg = c.light_purple, bg = nil, styles = {} },
  { name = "@keyword.repeat", fg = c.light_purple, bg = nil, styles = {} },

  ------------------------------------------------------------------------------
  -- Operators
  ------------------------------------------------------------------------------
  { name = "@operator", fg = c.white, bg = nil, styles = {} },
  { name = "@keyword.operator", fg = c.bright_red, bg = nil, styles = {} },

  ------------------------------------------------------------------------------
  -- Types
  ------------------------------------------------------------------------------
  { name = "@boolean", fg = c.cyan, bg = nil, styles = { "i" } },
  { name = "@constructor", fg = c.gold, bg = nil, styles = {} },
  { name = "@number", fg = c.white, bg = nil, styles = { "i" } },

  ------------------------------------------------------------------------------
  -- Punctuation
  ------------------------------------------------------------------------------
  { name = "@punctuation.delimiter", fg = c.white, bg = nil, styles = {} },
  { name = "@punctuation.bracket", fg = c.gold, bg = nil, styles = {} },

  ------------------------------------------------------------------------------
  -- Printf
  ------------------------------------------------------------------------------
  { name = "@character.printf", fg = c.bright_green, bg = nil, styles = {} },
}
