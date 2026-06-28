local highlights = require("bw.util.highlights")

return {
  {
    "LazyVim/LazyVim",
    opts = {
      icons = {
        kinds = {
          Snippet = "Տ ",
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = { "ribru17/blink-cmp-spell" },
    opts = function(_, opts)
      highlights.on_colorscheme("BlinkCmpHighlights", function()
        vim.cmd("hi! link BlinkCmpKind DiagnosticInfo")
        vim.cmd("hi! link BlinkCmpDoc Normal")
        vim.cmd("hi! link BlinkCmpDocSeparator WinSeparator")
        vim.cmd("hi! link BlinkCmpDocBorder FloatBorder")
        vim.cmd("hi! link BlinkCmpMenuBorder FloatBorder")
      end)

      local my_opts = {
        completion = {
          menu = { border = "single" },
          documentation = { window = { border = "single" } },
          list = {
            selection = {
              preselect = false,
              auto_insert = true,
            },
          },
        },
        sources = {
          -- `lsp`, `buffer`, `snippets`, `path` and `omni` are built-in
          -- so you don't need to define them in `sources.providers`.
          -- `spell` is appended to sources.default after the merge below rather
          -- than set here, so an index-aligned list merge can't clobber it.
          providers = {
            -- This is config for the ribru17/blink-cmp-spell dependency
            spell = {
              name = "Spell",
              module = "blink-cmp-spell",
              opts = {
                -- Only show suggestions when the word is misspelled (default: true)
                preselect_current_word = true,
                -- Max number of spell suggestions shown (default: 3)
                max_entries = 6,
                -- Show all spellsuggest results, not just fuzzy matches
                keep_all_entries = false,
                -- Optional: restrict to treesitter @spell captures only
                -- (great for e.g. comments/strings in code, not identifiers)
                enable_in_context = function()
                  -- Priority chain:
                  -- 1. Is vim spell off?           → no suggestions
                  -- 2. No treesitter parser?       → suggest everywhere
                  -- 3. In a @nospell capture?      → no suggestions
                  -- 4. In a @spell capture?        → suggest
                  -- 5. Neither (e.g. identifier)?  → no suggestions

                  if not vim.wo.spell then
                    return false
                  end

                  local curpos = vim.api.nvim_win_get_cursor(0)
                  local captures = vim.treesitter.get_captures_at_pos(0, curpos[1] - 1, curpos[2] - 1)

                  if vim.tbl_isempty(captures) then
                    return true
                  end

                  local in_spell_capture = false
                  for _, cap in ipairs(captures) do
                    if cap.capture == "spell" then
                      in_spell_capture = true
                    elseif cap.capture == "nospell" then
                      return false
                    end
                  end
                  return in_spell_capture
                end,

                use_cmp_spell_sorting = true,
              },
            },
          },
        },
        signature = {
          enabled = true,
          window = { border = "single" },
        },
      }
      local merged = vim.tbl_deep_extend("force", opts or {}, my_opts)
      -- Append our spell source rather than replacing sources.default, so the
      -- LazyVim base list (and anything an extra appends to it) is preserved.
      merged.sources = merged.sources or {}
      merged.sources.default = merged.sources.default or { "lsp", "buffer", "snippets", "path" }
      if not vim.tbl_contains(merged.sources.default, "spell") then
        table.insert(merged.sources.default, "spell")
      end
      return merged
    end,
  },
}
