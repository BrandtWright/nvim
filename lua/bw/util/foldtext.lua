local M = {}

--- Largest prefix of `s` whose display width is at most `width` (clamped to >= 0).
--- Truncates by display cells, not character count, so double-width glyphs (CJK,
--- emoji) can't push the result past `width`. The search starts at `width`
--- characters -- a string of display width `width` has at most that many chars,
--- since each is >= 1 cell -- so it is bounded by the window, not the line length.
---@param s string
---@param width integer
---@return string
local function truncate_to_width(s, width)
  if width <= 0 then
    return ""
  end
  if vim.fn.strdisplaywidth(s) <= width then
    return s
  end
  local n = math.min(vim.fn.strchars(s), width)
  while n > 0 and vim.fn.strdisplaywidth(vim.fn.strcharpart(s, 0, n)) > width do
    n = n - 1
  end
  return vim.fn.strcharpart(s, 0, n)
end

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
  -- Clamp at 0: a window narrower than the suffix yields a negative budget.
  local content_width = math.max(max_width - vim.fn.strdisplaywidth(prefix .. suffix), 0)

  -- Truncate to fit, reserving one cell for the ellipsis. By display width (not
  -- character count) so wide glyphs can't overflow content_width.
  if vim.fn.strdisplaywidth(line) > content_width then
    line = truncate_to_width(line, content_width - 1) .. "…"
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
