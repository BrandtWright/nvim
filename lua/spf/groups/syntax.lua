-- Syntax highlight groups -> primitives.            see :help 'group-name'
return {
  -- any comment
  Comment = "bright_black",

  -- any variable name
  Identifier = "white",

  -- any constant
  Constant = "bright_cyan",
  -- a character constant: 'c', '\n'
  Character = "Constant",
  -- a number constant: 234, 0xff
  Number = "Constant",
  -- a boolean constant: TRUE, false
  Boolean = "Constant",
  -- a floating point constant: 2.3e10
  Float = "Constant",

  -- a string constant: "this is a string"
  String = "orange",

  -- function name (also: methods for classes)
  Function = "yellow",

  -- any statement (flow control, return, etc.)
  Statement = "magenta",
  -- if, then, else, endif, switch, etc.
  Conditional = "Statement",
  -- for, do, while, etc.
  Repeat = "Statement",

  -- any other keyword
  Keyword = "blue",
  -- keywords TODO FIXME and XXX
  Todo = "blue",

  -- a typedef
  Typedef = "rose",

  -- case, default, etc.
  Label = "cyan",

  -- "sizeof", "+", "*", etc.
  Operator = "white",

  -- any erroneous construct
  Error = "red",

  -- try, catch, throw
  Exception = "Error",

  -- int, long, char, etc.
  Type = "green",

  -- static, register, volatile, etc.
  StorageClass = "bright_red",

  -- struct, union, enum, etc.
  Structure = "bright_green",

  -- generic Preprocessor
  PreProc = "blue",
  -- preprocessor #include
  Include = "PreProc",
  -- preprocessor #define
  Define = "PreProc",
  -- same as Define
  Macro = "PreProc",
  -- preprocessor #if, #else, #endif, etc.
  PreCondit = "PreProc",

  -- any special symbol
  Special = "bright_gold",
  -- special character in a constant
  SpecialChar = "Special",
  -- special things inside a comment
  SpecialComment = "Special",

  -- added line in a diff
  Added = "green",
  -- changed line in a diff
  Changed = "yellow",
  -- removed line in a diff
  Removed = "red",

  -- text that stands out, HTML links
  Underlined = "underline",

  -- character that needs attention
  Delimiter = "bright_white",

  -- you can use CTRL-] on this
  Tag = "cyan",

  -- debugging statements
  Debug = "magenta",

  -- left blank, hidden  |hl-Ignore|
  Ignore = "black_on_black",
}
