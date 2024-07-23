local c = require("bw.config.colors")

return {
  -- Treesitter
  { name = "@parameter.c_sharp", fg = nil, bg = nil, styles = { "i" } },
  { name = "@type.qualifier.c_sharp", fg = c.green, bg = nil, styles = {} },
  { name = "@exception.c_sharp", fg = c.red, bg = nil, styles = {} },
  { name = "@variable.member.c_sharp", fg = c.white, bg = nil, styles = {} },
  -- Semantic Tokens
  { name = "@lsp.type.class.cs", fg = c.green, bg = nil, styles = {} },
  { name = "@lsp.type.struct.cs", fg = c.teal, bg = nil, styles = {} },
  { name = "@lsp.type.property.cs", fg = c.white, bg = nil, styles = {} },
  { name = "@lsp.type.delegateName.cs", fg = c.very_light_purple, bg = nil, styles = {} },
  { name = "@lsp.type.extensionMethodName.cs", fg = c.green, bg = nil, styles = {} },
  { name = "@lsp.type.interface.cs", fg = c.light_gold, bg = nil, styles = {} },
  { name = "@lsp.type.parameter.cs", fg = nil, bg = nil, styles = { "i" } },
  { name = "@lsp.type.typeParameter.cs", fg = c.red, bg = nil, styles = {} },
  { name = "@lsp.mod.static.cs", fg = nil, bg = nil, styles = { "b" } },
  { name = "@lsp.typemod.constantName.static.cs", fg = c.bright_blue, bg = nil, styles = { "b" } },
  { name = "@lsp.type.keyword.cs", fg = c.blue, bg = nil, styles = {} },
}
