-- Filetype-specific groups (vimdoc, markdown, terraform).
return {
  -- Vimdoc
  ["@label.vimdoc"] = "Function",

  -- markdown
  markdownH1 = "bright_red_bold",
  markdownH2 = "red_bold",
  markdownH3 = "bright_orange_bold",
  markdownH4 = "orange",
  markdownH5 = "bright_yellow",
  markdownH6 = "yellow_italic",
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
