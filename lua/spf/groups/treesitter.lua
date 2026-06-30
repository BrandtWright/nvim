-- Treesitter @capture groups.        see :help treesitter-highlight-groups
return {
  -- various variable names -- the identifier family (this, @variable.member,
  -- @property) all link to Identifier so there's one source of truth.
  ["@variable"] = "Identifier",
  -- built-in variable names (e.g. `this`, `self`) -- a builtin is still a
  -- variable; follow the Identifier category rather than nvim's default Special
  -- (gold). See the "builtins follow their category" rule.
  ["@variable.builtin"] = "Identifier",
  -- parameters of a function -- italic, so a "passed in" variable is instantly
  -- distinguishable from a local (white). Same base color, just slanted; mirrors
  -- @lsp.type.parameter so TS-only and LSP buffers render the same.
  ["@variable.parameter"] = "italic",
  -- special parameters (e.g. `_`, `it`)
  ["@variable.parameter.builtin"] = {},
  -- object and struct fields -- a field is an identifier (restores nvim's
  -- default; unifies with @property).
  ["@variable.member"] = "Identifier",
  -- constant identifiers
  ["@constant"] = "Constant",
  -- built-in constant values (e.g. `nil`/`None`/`null`) -- a literal; follow
  -- Constant (bright_cyan) like @boolean/@number, not nvim's default Special.
  ["@constant.builtin"] = "Constant",
  -- constants defined by the preprocessor
  ["@constant.macro"] = {},
  -- modules or namespaces -- a scope/container is type-adjacent but distinct;
  -- bright_green (rehomed from the old struct-keyword role). Decoupled from the
  -- @module -> Structure default link; propagates to @lsp.type.namespace.
  ["@module"] = "bright_green",
  -- built-in modules or namespaces -- follow the namespace category; anchor to
  -- the @module capture (no legacy "Module" group) so both track bright_green.
  ["@module.builtin"] = "@module",
  -- `GOTO` and other labels (e.g. `label:` in C), including heredoc labels
  ["@label"] = {},
  -- string literals
  ["@string"] = {},
  -- string documenting code (e.g. Python docstrings)
  ["@string.documentation"] = {},
  -- regular expressions
  ["@string.regexp"] = {},
  -- escape sequences
  ["@string.escape"] = {},
  -- other special strings (e.g. dates)
  ["@string.special"] = {},
  -- symbols or atoms
  ["@string.special.symbol"] = {},
  -- filenames
  ["@string.special.path"] = {},
  -- URIs (e.g. hyperlinks)
  ["@string.special.url"] = {},
  -- character literals
  ["@character"] = {},
  -- special characters (e.g. wildcards)
  ["@character.special"] = {},
  -- boolean literals
  ["@boolean"] = {},
  -- numeric literals
  ["@number"] = {},
  -- floating-point number literals
  ["@number.float"] = {},
  -- type or class definitions and annotations
  ["@type"] = {},
  -- built-in types (e.g. `int`/`bool`/`str`) -- a type is a type; follow Type
  -- (green) so "type names are green" holds, not nvim's default Special.
  ["@type.builtin"] = "Type",
  -- identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)
  ["@type.definition"] = {},
  -- attribute annotations (e.g. Python decorators, Rust lifetimes)
  ["@attribute"] = {},
  -- builtin annotations (e.g. `@property` in Python) -- follow the attribute
  -- category; anchor to @attribute (no legacy group) instead of nvim's Special.
  ["@attribute.builtin"] = "@attribute",
  -- the key in key/value pairs -- a field is an identifier, not a type; keeps
  -- green meaning "types" (unified with @variable.member).
  ["@property"] = "Identifier",
  -- function definitions
  ["@function"] = {},
  -- built-in functions (e.g. `print`/`len`) -- a function is a function; follow
  -- Function (yellow), not nvim's default Special.
  ["@function.builtin"] = "Function",
  -- function calls
  ["@function.call"] = "yellow_italic",
  -- preprocessor macros
  ["@function.macro"] = {},
  -- method definitions
  ["@function.method"] = {},
  -- method calls -- "calls are italic": method calls italicize like @function.call
  -- (definitions stay plain yellow), so an invocation reads distinctly everywhere.
  ["@function.method.call"] = "yellow_italic",
  -- constructor calls and definitions
  ["@constructor"] = {},
  -- symbolic operators (e.g. `+`, `*`)
  ["@operator"] = {},
  -- keywords not fitting into specific categories
  ["@keyword"] = {},
  -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
  ["@keyword.coroutine"] = {},
  -- keywords that define a function (e.g. `func` in Go, `def` in Python)
  ["@keyword.function"] = "Keyword",
  -- operators that are English words (e.g. `and`, `or`, `not`, `in`, `is`) --
  -- their own category: identifier-shaped operators that need disambiguating from
  -- variables (unlike self-evident symbolic operators, which stay neutral via
  -- @operator/Operator = white). rose, a hue used by nothing else.
  ["@keyword.operator"] = "rose",
  -- keywords for including or exporting modules (e.g. `import`, `from` in Python)
  -- -- declarative, preprocessor-family (blue), distinct from flow control.
  ["@keyword.import"] = "PreProc",
  -- keywords describing namespaces and composite types (e.g. `struct`, `enum`)
  -- -- declaration keyword is a keyword/blue, like `class` (mirrors Structure).
  ["@keyword.type"] = "Keyword",
  -- keywords modifying other constructs (e.g. `const`, `static`, `public`)
  -- -- modifier keywords, keyword/blue (mirrors StorageClass).
  ["@keyword.modifier"] = "Keyword",
  -- keywords related to loops (e.g. `for`, `while`) -- flow control; link to the
  -- Statement anchor (not the raw color) so all control flow recolors in one edit.
  ["@keyword.repeat"] = "Statement",
  -- keywords like `return` and `yield` -- flow control, magenta (Statement).
  ["@keyword.return"] = "Statement",
  -- keywords related to debugging
  ["@keyword.debug"] = {},
  -- keywords related to exceptions (e.g. `throw`, `catch`) -- flow control,
  -- magenta (Statement), not the error hue (mirrors Exception).
  ["@keyword.exception"] = "Statement",
  -- keywords related to conditionals (e.g. `if`, `else`) -- flow control; link to
  -- the Statement anchor (not the raw color) so all control flow recolors at once.
  ["@keyword.conditional"] = "Statement",
  -- ternary operator (e.g. `?`, `:`)
  ["@keyword.conditional.ternary"] = {},
  -- various preprocessor directives and shebangs
  ["@keyword.directive"] = {},
  -- preprocessor definition directives
  ["@keyword.directive.define"] = {},
  -- delimiters (e.g. `;`, `.`, `,`)
  ["@punctuation.delimiter"] = {},
  -- brackets (e.g. `()`, `{}`, `[]`)
  ["@punctuation.bracket"] = {},
  -- special symbols (e.g. `{}` in string interpolation)
  ["@punctuation.special"] = {},
  -- line and block comments
  ["@comment"] = {},
  -- comments documenting code
  ["@comment.documentation"] = {},
  -- error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
  ["@comment.error"] = {},
  -- warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
  ["@comment.warning"] = {},
  -- todo-type comments (e.g. `TODO`, `WIP`)
  ["@comment.todo"] = {},
  -- note-type comments (e.g. `NOTE`, `INFO`, `XXX`)
  ["@comment.note"] = {},
  -- bold text
  ["@markup.strong"] = {},
  -- italic text
  ["@markup.italic"] = {},
  -- struck-through text
  ["@markup.strikethrough"] = {},
  -- underlined text (only for literal underline markup!)
  ["@markup.underline"] = {},
  -- headings, titles (including markers)
  ["@markup.heading"] = {},
  -- top-level heading
  ["@markup.heading.1"] = {},
  -- section heading
  ["@markup.heading.2"] = {},
  -- subsection heading
  ["@markup.heading.3"] = {},
  -- and so on
  ["@markup.heading.4"] = {},
  -- and so forth
  ["@markup.heading.5"] = {},
  -- six levels ought to be enough for anybody
  ["@markup.heading.6"] = {},
  -- block quotes
  ["@markup.quote"] = "italic",
  -- math environments (e.g. `$ ... $` in LaTeX)
  ["@markup.math"] = {},
  -- text references, footnotes, citations, etc.
  ["@markup.link"] = "blue",
  -- link, reference descriptions
  ["@markup.link.label"] = "blue",
  -- URL-style links
  ["@markup.link.url"] = "magenta",
  -- literal or verbatim text (e.g. inline code)
  ["@markup.raw"] = "orange",
  -- literal or verbatim text as a stand-alone block
  ["@markup.raw.block"] = {},
  -- list markers
  ["@markup.list"] = {},
  -- checked todo-style list markers
  ["@markup.list.checked"] = "green",
  -- unchecked todo-style list markers
  ["@markup.list.unchecked"] = "red",
  -- added text (for diff files)
  ["@diff.plus"] = {},
  -- deleted text (for diff files)
  ["@diff.minus"] = {},
  -- changed text (for diff files)
  ["@diff.delta"] = {},
  -- XML-style tag names (e.g. in XML, HTML, etc.)
  ["@tag"] = {},
  -- builtin tag names (e.g. HTML5 tags like `<div>`) -- follow the tag category
  -- (Tag = cyan) so builtin and custom tags match, not nvim's default Special.
  ["@tag.builtin"] = "Tag",
  -- XML-style tag attributes
  ["@tag.attribute"] = {},
  -- XML-style tag delimiters
  ["@tag.delimiter"] = {},
}
