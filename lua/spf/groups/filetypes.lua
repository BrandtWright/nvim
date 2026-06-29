-- Filetype-specific groups (vimdoc, markdown, terraform).
return {
  -- Vimdoc
  ["@label.vimdoc"] = "Function",

  -- markdown
  markdownH1 = "Title",
  markdownH2 = "bright_gold",
  markdownH3 = "markdownH2",
  markdownH4 = "markdownH2",
  markdownH5 = "markdownH2",
  markdownH6 = "markdownH2",
  ["@markup.heading.1.markdown"] = "markdownH1",
  ["@markup.heading.2.markdown"] = "markdownH2",
  ["@markup.heading.3.markdown"] = "markdownH3",
  ["@markup.heading.4.markdown"] = "markdownH4",
  ["@markup.heading.5.markdown"] = "markdownH5",
  ["@markup.heading.6.markdown"] = "markdownH6",
  markdownCode = "nothing_on_cursorline",
  markdownCodeBlock = "markdownCode",
  markdownCodeDelimiter = {},
  markdownBlockquote = {},
  markdownListMarker = "bright_gold",
  markdownOrderedListMarker = {},
  markdownRule = {},
  markdownHeadingRule = {},
  markdownUrlDelimiter = {},
  markdownLinkDelimiter = {},
  markdownLinkTextDelimiter = {},
  markdownHeadingDelimiter = {},
  markdownUrl = {},
  markdownUrlTitleDelimiter = {},
  markdownLinkText = {},
  markdownIdDeclaration = {},

  -- Terraform
  ["@lsp.type.type.terraform"] = "Keyword",
}
