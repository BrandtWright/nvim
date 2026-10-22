-- Health provider for this config: `:checkhealth bw`.
--
-- The config shells out to a handful of external tools. Most fail soft (a
-- picker returns nothing, the spf palette falls back to baked-in colors, an
-- export keymap errors), so a missing tool is otherwise only discovered when a
-- feature silently does nothing. This surfaces the whole inventory at once.
--
-- Keep M.tools in sync with README.md's Requirements section.

local M = {}

-- Report sections, in display order. Grouping follows mason.nvim's health
-- check: language toolchains get their own heading, so a warning for a language
-- not used on this machine reads as exactly that, not as a broken core feature.
M.sections = {
  { key = "core", title = "bw: core tools" },
  { key = "features", title = "bw: feature tools" },
  { key = "languages", title = "bw: language toolchains" },
}

-- Declarative inventory of every external command this config (and the LazyVim
-- extras it imports) invokes, beyond what Mason installs.
--   section = key of the M.sections heading it's reported under
--   level   = "required" -> a core feature is broken without it (CI/lint aside)
--             "optional" -> one specific feature degrades; the rest is fine
--   reason  = the feature it powers, phrased for the checkhealth reader
M.tools = {
  -- stylua: ignore start
  { section = "core", name = "git", level = "required", reason = "plugin management (lazy.nvim) and the git pickers" },
  { section = "core", name = "rg", level = "required", reason = "grep pickers (Snacks.picker.grep)" },
  { section = "core", name = "fd", level = "required", reason = "file pickers (Snacks.picker.files)" },
  { section = "core", name = "cc", level = "required", reason = "treesitter compiles its parsers (highlighting, folding)" },
  { section = "core", name = "curl", level = "required", reason = "downloads for Mason, treesitter parsers, and markdown-preview" },
  { section = "core", name = "tar", level = "required", reason = "unpacking Mason and treesitter downloads" },
  { section = "core", name = "gzip", level = "required", reason = "unpacking Mason and treesitter downloads" },
  { section = "core", name = "unzip", level = "required", reason = "unpacking Mason downloads" },
  { section = "core", name = "node", level = "required", reason = "npm-based Mason tools (bash/TS/JSON/YAML LSPs, markdownlint-cli2) and Copilot" },
  { section = "core", name = "npm", level = "required", reason = "installing npm-based Mason tools" },
  { section = "core", name = "python3", level = "optional", reason = "pip-based Mason tools, e.g. ansible-lint (also needs the venv module)" },
  { section = "features", name = "snote", level = "optional", reason = "slipbox: :SlipNew / :SlipEdit / save" },
  { section = "features", name = "xrdb", level = "optional", reason = "spf palette from xresources (falls back to baked-in colors)" },
  { section = "features", name = "find-dotfiles", level = "optional", reason = "<leader>f. dotfiles picker" },
  { section = "features", name = "dict", level = "optional", reason = "<leader>sw dictionary lookup" },
  { section = "features", name = "pandoc", level = "optional", reason = "markdown export (<leader>mp / HTML)" },
  { section = "features", name = "zathura", level = "optional", reason = "markdown PDF preview (<leader>mp)" },
  { section = "features", name = "tmux", level = "optional", reason = "tmux zen-mode status toggle (only used inside tmux)" },
  { section = "features", name = "lazygit", level = "optional", reason = "<leader>gg lazygit (LazyVim maps it only when installed)" },
  { section = "features", name = "ranger", level = "optional", reason = ":Ranger file manager (fm-nvim)" },
  { section = "features", name = "vifm", level = "optional", reason = ":Vifm file manager and the _ keymap (fm-nvim)" },
  { section = "languages", name = "ghc", level = "optional", reason = "Haskell: haskell-language-server needs a GHC toolchain (ghcup)" },
  { section = "languages", name = "cabal-fmt", level = "optional", reason = "Haskell: formatting .cabal files (not in Mason)" },
  { section = "languages", name = "rust-analyzer", level = "optional", reason = "Rust LSP (rustaceanvim); rustup component add rust-analyzer" },
  { section = "languages", name = "terraform", level = "optional", reason = "Terraform: formatting and validation" },
  { section = "languages", name = "packer", level = "optional", reason = "HCL formatting (packer_fmt; not in Mason)" },
  { section = "languages", name = "dotnet", level = "optional", reason = "C#/F#: Mason installs csharpier and fantomas as dotnet tools" },
  -- stylua: ignore end
}

--- Classifies the tool inventory against an executable-probe, without touching
--- the vim.health UI. Pure (the probe is injected), so it is unit-testable.
--- A present tool is "ok"; a missing one is "error" when required, "warn" when
--- optional.
---@param tools { section: string, name: string, level: string, reason: string }[]
---@param is_executable fun(name: string): boolean
---@return { section: string, name: string, level: string, reason: string, present: boolean, status: "ok"|"warn"|"error" }[]
function M.evaluate(tools, is_executable)
  local results = {}
  for _, t in ipairs(tools) do
    local present = is_executable(t.name)
    local status = present and "ok" or (t.level == "required" and "error" or "warn")
    results[#results + 1] = {
      section = t.section,
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
--- each external tool's presence under its section heading.
function M.check()
  vim.health.start("bw: Neovim version")
  if vim.fn.has("nvim-0.12") == 1 then
    local v = vim.version()
    vim.health.ok(string.format("Neovim %d.%d.%d", v.major, v.minor, v.patch))
  else
    vim.health.error("Neovim 0.12+ required (this config uses 0.12-only APIs: vim.lsp.enable, etc.)")
  end

  local results = M.evaluate(M.tools, function(name)
    return vim.fn.executable(name) == 1
  end)
  for _, section in ipairs(M.sections) do
    vim.health.start(section.title)
    for _, r in ipairs(results) do
      if r.section == section.key then
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
  end
end

return M
