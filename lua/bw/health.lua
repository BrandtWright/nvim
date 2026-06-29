-- Health provider for this config: `:checkhealth bw`.
--
-- The config shells out to a handful of external tools. Most fail soft (a
-- picker returns nothing, the spf palette falls back to baked-in colors, an
-- export keymap errors), so a missing tool is otherwise only discovered when a
-- feature silently does nothing. This surfaces the whole inventory at once.
--
-- Keep M.tools in sync with README.md's Requirements section.

local M = {}

-- Declarative inventory of every external command this config invokes.
--   level  = "required" -> a core feature is broken without it (CI/lint aside)
--            "optional" -> one specific feature degrades; the rest is fine
--   reason = the feature it powers, phrased for the checkhealth reader
M.tools = {
  { name = "git", level = "required", reason = "plugin management (lazy.nvim) and the git pickers" },
  { name = "rg", level = "required", reason = "grep pickers (Snacks.picker.grep)" },
  { name = "fd", level = "required", reason = "file pickers (Snacks.picker.files)" },
  { name = "snote", level = "optional", reason = "slipbox: :SlipNew / :SlipEdit / save" },
  { name = "xrdb", level = "optional", reason = "spf palette from xresources (falls back to baked-in colors)" },
  { name = "find-dotfiles", level = "optional", reason = "<leader>f. dotfiles picker" },
  { name = "dict", level = "optional", reason = "<leader>sw dictionary lookup" },
  { name = "pandoc", level = "optional", reason = "markdown export (<leader>mp / HTML)" },
  { name = "zathura", level = "optional", reason = "markdown PDF preview (<leader>mp)" },
  { name = "tmux", level = "optional", reason = "tmux zen-mode status toggle (only used inside tmux)" },
}

--- Classifies the tool inventory against an executable-probe, without touching
--- the vim.health UI. Pure (the probe is injected), so it is unit-testable.
--- A present tool is "ok"; a missing one is "error" when required, "warn" when
--- optional.
---@param tools { name: string, level: string, reason: string }[]
---@param is_executable fun(name: string): boolean
---@return { name: string, level: string, reason: string, present: boolean, status: "ok"|"warn"|"error" }[]
function M.evaluate(tools, is_executable)
  local results = {}
  for _, t in ipairs(tools) do
    local present = is_executable(t.name)
    local status = present and "ok" or (t.level == "required" and "error" or "warn")
    results[#results + 1] = {
      name = t.name,
      level = t.level,
      reason = t.reason,
      present = present,
      status = status,
    }
  end
  return results
end

--- checkhealth entry point. Reports the Neovim floor this config requires, then
--- each external tool's presence.
function M.check()
  vim.health.start("bw: Neovim version")
  if vim.fn.has("nvim-0.12") == 1 then
    local v = vim.version()
    vim.health.ok(string.format("Neovim %d.%d.%d", v.major, v.minor, v.patch))
  else
    vim.health.error("Neovim 0.12+ required (this config uses 0.12-only APIs: vim.lsp.enable, etc.)")
  end

  vim.health.start("bw: external tools")
  local results = M.evaluate(M.tools, function(name)
    return vim.fn.executable(name) == 1
  end)
  for _, r in ipairs(results) do
    local msg = string.format("%s — %s", r.name, r.reason)
    if r.status == "ok" then
      vim.health.ok(msg)
    elseif r.status == "error" then
      vim.health.error(msg .. " (not found)")
    else
      vim.health.warn(msg .. " (not found; this feature is unavailable)")
    end
  end
end

return M
