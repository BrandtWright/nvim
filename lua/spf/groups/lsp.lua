-- LSP reference + semantic-token groups.            see :help lsp-highlight
return {
  -- used for highlighting "text" references
  LspReferenceText = "bold",
  -- used for highlighting "read" references
  LspReferenceRead = "bold",
  -- used for highlighting "write" references
  LspReferenceWrite = "bold",
  -- used for highlighting reference targets (e.g. in a hover range)
  LspReferenceTarget = "bold",
  -- used for highlighting inlay hints
  LspInlayHint = "bright_black",

  ------------------------------------------------------------------------------
  -- LSP Semantic Highlights                       see: :help 'highlight-groups'
  ------------------------------------------------------------------------------

  -- Identifiers that declare or reference a class type
  ["@lsp.type.class"] = {},
  -- Tokens that represent a comment
  ["@lsp.type.comment"] = "Comment",
  -- Identifiers that declare or reference decorators and annotations
  ["@lsp.type.decorator"] = {},
  -- Identifiers that declare or reference an enumeration type
  ["@lsp.type.enum"] = {},
  -- Identifiers that declare or reference an enumeration property, constant, or member
  ["@lsp.type.enumMember"] = {},
  -- Identifiers that declare an event property
  ["@lsp.type.event"] = {},
  -- Identifiers that declare a function
  ["@lsp.type.function"] = "Function",
  -- Identifiers that declare or reference an interface type
  ["@lsp.type.interface"] = {},
  -- Tokens that represent a language keyword
  ["@lsp.type.keyword"] = {},
  -- Identifiers that declare a macro
  ["@lsp.type.macro"] = {},
  -- Identifiers that declare a member function or method
  ["@lsp.type.method"] = "Function",
  -- Tokens that represent a modifier
  ["@lsp.type.modifier"] = {},
  -- Identifiers that declare or reference a namespace, module, or package
  ["@lsp.type.namespace"] = {},
  -- Tokens that represent a number literal
  ["@lsp.type.number"] = {},
  -- Tokens that represent an operator
  ["@lsp.type.operator"] = {},
  -- Identifiers that declare or reference a function or method parameters
  ["@lsp.type.parameter"] = "italic",
  -- Identifiers that declare or reference a member property, member field, or member variable
  -- Left to inherit nvim's default (-> Identifier), so LSP buffers (e.g. tsserver)
  -- render fields the same as treesitter's @property/@variable.member. An explicit
  -- color here would override treesitter and make TS/JS diverge.
  ["@lsp.type.property"] = {},
  -- Tokens that represent a regular expression literal
  ["@lsp.type.regexp"] = {},
  -- Tokens that represent a string literal
  ["@lsp.type.string"] = {},
  -- Identifiers that declare or reference a struct type
  ["@lsp.type.struct"] = {},
  -- Identifiers that declare or reference a type that is not covered above
  ["@lsp.type.type"] = {},
  -- Identifiers that declare or reference a type parameter
  ["@lsp.type.typeParameter"] = {},
  -- Identifiers that declare or reference a local or global variable
  ["@lsp.type.variable"] = {},
  -- Types and member functions that are abstract
  ["@lsp.mod.abstract"] = {},
  -- Functions that are marked async
  ["@lsp.mod.async"] = {},
  -- Declarations of symbols
  ["@lsp.mod.declaration"] = {},
  -- Symbols that are part of the standard library
  ["@lsp.mod.defaultLibrary"] = {},
  -- Definitions of symbols, for example, in header files
  ["@lsp.mod.definition"] = {},
  -- Symbols that should no longer be used
  ["@lsp.mod.deprecated"] = {},
  -- Occurrences of symbols in documentation
  ["@lsp.mod.documentation"] = {},
  -- Variable references where the variable is assigned to
  ["@lsp.mod.modification"] = {},
  -- Readonly variables and member fields (constants)
  ["@lsp.mod.readonly"] = {},
  -- Class members (static members)
  ["@lsp.mod.static"] = {},
}
