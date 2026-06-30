local highlights = require("bw.util.highlights")

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = function(_, opts)
      highlights.on_colorscheme("RenderMarkdownHighlights", function()
        vim.cmd("hi! link RenderMarkdownH1Bg markdownH1")
        vim.cmd("hi! link RenderMarkdownH2Bg markdownH2")
        vim.cmd("hi! link RenderMarkdownH3Bg markdownH3")
        vim.cmd("hi! link RenderMarkdownH4Bg markdownH4")
        vim.cmd("hi! link RenderMarkdownH5Bg markdownH5")
        vim.cmd("hi! link RenderMarkdownH6Bg markdownH6")
        vim.cmd("hi! link RenderMarkdownQuote1 Special")
        vim.cmd("hi! link RenderMarkdownQuote2 RenderMarkdownQuote1")
        vim.cmd("hi! link RenderMarkdownQuote3 RenderMarkdownQuote1")
        vim.cmd("hi! link RenderMarkdownQuote4 RenderMarkdownQuote1")
        vim.cmd("hi! link RenderMarkdownQuote5 RenderMarkdownQuote1")
        vim.cmd("hi! link RenderMarkdownQuote6 RenderMarkdownQuote1")
        -- render-markdown renders inside the snacks picker preview, and that
        -- preview RESERVES a set of highlight groups: it remaps them window-locally
        -- via winhighlight (see snacks/picker/core/preview.lua). The reserved
        -- groups are: NormalFloat, FloatBorder, FloatTitle, FloatFooter, and
        -- CursorLine (-> Visual). winhighlight follows link chains, so any
        -- RenderMarkdown* group that resolves THROUGH one of those names will pick
        -- up the preview's remapped color instead of the intended one.
        --
        -- => When choosing a link target for anything that can appear in a preview,
        --    make sure it does not resolve (directly or via links) to a reserved
        --    group. ColorColumn is a standard, safe target for the code background.
        vim.cmd("hi! link RenderMarkdownCode ColorColumn")
        vim.cmd("hi! link RenderMarkdownTableHead FloatBorder")
        vim.cmd("hi! link RenderMarkdownTableRow FloatBorder")
        vim.cmd("hi! link RenderMarkdownBullet markdownListMarker")
      end)

      local my_opts = {
        code = {
          right_pad = 2,
          left_pad = 2,
        },
        link = {
          custom = {
            web = {
              icon = "",
            },
          },
        },
        -- Checkboxes are status indicators: each state maps to a diagnostic
        -- status color (the status palette lives in spf -- DiagnosticOk/Hint/
        -- Info/Warn/Error -- so the colorscheme stays the source of truth; this
        -- only assigns each STATE to a STATUS). Treesitter natively distinguishes
        -- only checked/unchecked (anchored in spf, item 12); the extended states
        -- below are render-markdown custom states. See colors.md item 13.
        --
        -- Icons are nerd-font glyphs -- adjust to taste / your font; the colors,
        -- not the glyphs, carry the semantics.
        checkbox = {
          enabled = true,
          -- done -> DiagnosticOk (green); to-do -> DiagnosticHint (magenta).
          -- Follow the treesitter groups so spf remains the single source.
          unchecked = { highlight = "@markup.list.unchecked" },
          checked = { highlight = "@markup.list.checked" },
          -- Icons are Font Awesome basics written as \u{} escapes (the literal
          -- glyphs got mangled to spaces once already). Present in any nerd font;
          -- swap to taste. The status COLOR carries the meaning, not the glyph.
          custom = {
            -- `todo` is render-markdown's built-in key for `[-]`; repurpose it as
            -- "cancelled" (Obsidian convention): gray marker + struck-through text.
            -- \u{f00d} = times (✗)
            todo = { raw = "[-]", rendered = "\u{f00d} ", highlight = "Comment", scope_highlight = "DiagnosticDeprecated" },
            -- in progress -> Info (blue). \u{f254} = hourglass
            in_progress = { raw = "[/]", rendered = "\u{f254} ", highlight = "DiagnosticInfo" },
            -- deferred / waiting -> Warn (yellow). \u{f017} = clock
            waiting = { raw = "[>]", rendered = "\u{f017} ", highlight = "DiagnosticWarn" },
            -- important / urgent -> Error (red). \u{f071} = warning triangle
            important = { raw = "[!]", rendered = "\u{f071} ", highlight = "DiagnosticError" },
            -- question / uncertain -> Hint (magenta). \u{f059} = question circle
            question = { raw = "[?]", rendered = "\u{f059} ", highlight = "DiagnosticHint" },
          },
        },
        overrides = {
          -- With code.width = "block", render-markdown masks the area beside a code
          -- block using padding whose highlight defaults to Normal. In a snacks
          -- picker preview (a float) the surrounding bg is NormalFloat, so that
          -- padding shows as a Normal-colored stripe under colorschemes where
          -- Normal != NormalFloat.
          --
          -- render-markdown ships a `nofile` buftype override that fixes this
          -- (padding.highlight = NormalFloat), but snacks gives file previews
          -- buftype="" (not "nofile"), so it never matches. Those preview buffers
          -- ARE unlisted, so key the override on buflisted=false instead. snacks
          -- then remaps NormalFloat to the preview bg, so the padding blends in.
          buflisted = {
            [false] = { padding = { highlight = "NormalFloat" } },
          },
        },
      }

      return vim.tbl_deep_extend("force", opts or {}, my_opts)
    end,
  },
}
