local M = {}

--- Builds custom fold text: the trimmed first line of the fold plus a
--- "[N lines]" suffix, truncated with an ellipsis when it would overflow and
--- right-padded to fill the window width.
---
--- Pure: all window/buffer state is passed in, so it is unit-testable. The
--- `_G.TreesitterFoldText` wrapper in config/options.lua gathers the live
--- values and delegates here.
---@param o { line: string, count: integer, width: integer }
---@return string
function M.build(o)
  local suffix = string.format("  … [%d lines]", o.count)
  local prefix = " "
  local max_width = o.width - 2 -- allow for the fold column
  local line = vim.trim(o.line)
  local content_width = max_width - vim.fn.strdisplaywidth(prefix .. suffix)

  -- truncate if needed
  if vim.fn.strdisplaywidth(line) > content_width then
    line = vim.fn.strcharpart(line, 0, content_width - 1) .. "…"
  end

  -- left-justified + padded manually
  local foldtext = prefix .. line .. suffix
  local total_padding = max_width - vim.fn.strdisplaywidth(foldtext)
  if total_padding > 0 then
    foldtext = foldtext .. string.rep(" ", total_padding)
  end

  return foldtext
end

return M
