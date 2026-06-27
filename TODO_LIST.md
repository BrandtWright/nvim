# Neovim Config — TODO List

Tracking remediation of the config review (see findings from the evaluation pass).
Status legend: `[ ]` not started · `[~]` in progress · `[x]` done · `[-]` won't do / N/A

Items marked **✓verified** were confirmed by reading the code directly. Others come
from review and should be re-verified before changing.

---

## 1. Confirmed bugs (high value, low risk)

- [x] **fillchars clobbered** — `lua/config/options.lua:69-75` & `:141`. Line 141
  `opt.fillchars = { eob = "~" }` replaces the whole table set at 69-75, dropping
  fold glyphs (`foldopen`/`foldclose`/`foldsep`/`fold`) and overriding `eob`. Merge
  into one assignment. **✓verified** — commit 928b332
- [x] **Global option leak in ftplugin** — `after/ftplugin/lua.lua:9`. Uses
  `vim.opt.expandtab` (global) instead of `vim.opt_local`/`o.expandtab`; leaks to
  every buffer when a Lua file is opened. **✓verified** — commit d965f85
- [x] **Invalid color fallback** — `lua/bw/config/colors.lua:45`. `white` fallback
  `"ebdbb2"` is missing the leading `#`. **✓verified** — commit 97d385b
- [x] **`buff_exceeds_size` returns nil** — `lua/bw/util/fs.lua:54-58`. Add explicit
  `return false` on the else path. **✓verified** — commit 4c1d022
- [x] **Telescope `vertical`/`flex` misplaced** — `lua/plugins/telescope.lua:66,72`.
  They are siblings of `layout_config`; move them inside `defaults.layout_config`. **✓verified** — commit cd2f8a5
- [x] **Telescope extensions never loaded** — `lua/plugins/telescope.lua:79-101`. `fzf`
  configured but `telescope-fzf-native` not a dependency; no `load_extension` calls.
  **✓verified** — commit 0b2e1b9. Removed dead fzf/ui-select/notify/emoji/file_browser
  config + their deps. NOTE: `project` was NOT dead — `config/keymaps.lua:219` accesses
  `telescope.extensions.project` (telescope auto-loads on access), so it + its dep were
  kept. (Original prune list in the review was wrong to include `project`.)
- [x] **which-key typo** — `lua/plugins/ui.lua:80`. `preset = "clasic"` → `"classic"`. **✓verified** — commit a170de1
- [x] **vim-illuminate not disabled** — `lua/plugins/lazy-overrides.lua:64`. Bare name
  `"vim-illuminate"` → `"RRethy/vim-illuminate"` so the disable actually applies. **✓verified** — commit 9d94627
- [x] **~30 blocking `xrdb` calls on startup** — `lua/bw/config/colors.lua:27-33`.
  `load_color` shells out per-color; migrate onto the already-batched/cached
  `lua/bw/util/xresources.lua` (TODO already noted in file). **✓verified** — commit 8a426db

## 2. Likely bugs / footguns (re-verify, then fix)

All items verified with a headless plenary test harness (tests/, added in this
batch). Each fix ships with a spec; run `tests/run.sh`. See MANUAL_SMOKE.md for
the in-editor checks the harness can't cover.

- [x] **git/api cwd pipeline is decorative** — `lua/plugins/git/api.lua`. Validates
  `opts.cwd` but calls `Snacks.picker.*()` with no args, so cwd is never passed.
  Also `git -C <path>` built with unescaped `string.format` (breaks on spaces).
  **commit 3d6d4ee** — pass validated opts to pickers; vim.system argv form;
  normalize cwd. tests/git_api_spec.lua (incl. space-in-path; red/green proven).
- [-] **`ft=` in lazy `keys` creates global maps** — `navigation.lua` / `git/init.lua`.
  FALSE POSITIVE. lazy.nvim's keys handler only makes a global map in the non-ft
  branch (`add()`); with `ft` it creates a FileType autocmd + buffer-local map
  (verified in lazy source: lua/lazy/core/handler/keys.lua:150-166). No change.
  **commit 2c3ae77** added tests/keymaps_ft_spec.lua to guard the `ft` invariant.
- [x] **snacks picker resolved at spec-load** — `lua/plugins/picker.lua`.
  **commit 7df12b6** — defer `require("snacks").picker` into keymap closures.
  tests/picker_spec.lua (imports with snacks absent; red/green proven).
- [x] **diagnostics toggle mutates live config** — `lua/plugins/diagnostics.lua`.
  **commit a7c54ea** — get() returns a boolean; set() remembers the rich config
  and restores it; no live-table mutation. tests/diagnostics_spec.lua.
- [x] **colorizer is a no-op** — `lua/plugins/ui.lua`. **commit 997407e** —
  ACTIVATED (event=VeryLazy + config calls setup()). tests/colorizer_spec.lua.
- [x] **frozen cwd** — `lua/plugins/floating-terminal.lua`. **commit 156f400** —
  drop frozen cwd; pass live `vim.fn.getcwd()` at toggle. tests/floating_terminal_spec.lua.
- [x] **slipbox save autocmd path** — `lua/user/slipbox/init.lua`. **commit 1858e2e** —
  normalize root once in setup(); extract slip_id_from_path() with vim.pesc.
  tests/slipbox_spec.lua (root seeded with magic chars; teeth proven).
- [x] **dead picker `action` closures** — `lua/plugins/pickers/slips.lua`.
  **commit ff64b20** — removed dead actions on slipbox/related_slips (default
  file-open confirm already covers them). tests/slips_picker_spec.lua.

## 3. `.vim` ftplugin bugs (consider porting to `.lua`)

- [x] **sql.vim** — a line of Lua (`vim.opt_local.commentstring = ...`) inside a
  vimscript file; commentstring never set. **commit a5910d5** — valid vimscript
  `setlocal commentstring=--\ %s`. tests/ftplugin_spec.lua (sourced directly).
- [x] **term.vim** — malformed `match` autocmds (E488), undefined hl groups, never
  worked. **commit b935594** — removed the TermWhitespace augroup (user choice);
  kept setlocal opts + `<C-]>` tnoremap. tests/ftplugin_spec.lua.
- [x] **python.vim** — window-scoped `:match` leaked across buffers. **commit b935594**
  — replaced with buffer-local `setlocal colorcolumn=81` (user choice; matches
  cs.vim). tests/ftplugin_spec.lua.
- [-] (stretch) Consolidate remaining `.vim` ftplugins to `.lua` — not pursued; the
  remaining `.vim` ftplugins (c/cpp/cmake/cs/markdown/netrw/rust/vimwiki/xml) are
  simple valid `setlocal`s. No need.

Harness note: minimal_init now puts the config's `after/` dir on the rtp so
ftplugins can be tested; specs source the ftplugin files directly because
plenary's headless env doesn't fully drive filetype detection.

## 4. Architecture decisions (discuss before acting)

- [ ] **Telescope vs snacks picker** — both fully configured; telescope loads eagerly
  every startup (no lazy trigger) with 6 deps, alongside the default snacks picker.
  Decide on one. If keeping telescope, at least add `cmd`/`keys` lazy triggers.
- [ ] **snacks.nvim opts fragmented across ~8 files** — consider consolidating.
- [ ] **Side-effectful highlight/toggle setup inside `opts` functions** (~9 files) —
  move to `config` hook; `opts` can run multiple times during merge.
- [ ] **`bw/types` half-finished** — `Maybe` and `List` are dead code; `List:bind`
  unsafe; none expose `map`. Flesh out or drop.
- [ ] **`after/plugin/globals.lua`** runs every startup outside Lazy's lifecycle —
  decide whether to keep / relocate.

## 5. Convention cleanup (low priority)

- [ ] **Wrong `desc` strings in `lua/config/keymaps.lua`**: `<leader>ws` "Vertical
  Split" (it's horizontal, :40); window-move H/K/L scrambled (:50-53); `<C-n>`/`<C-p>`
  scroll labels swapped (:30-31); `]q`/`[q` quickfix inverted (:160-161); `<F7>`
  "Project" (:18); `<leader>xc` duplicates `<leader>xj` (:162-163).
- [ ] **Stale comment banners**: floating-terminal.lua says "Indent"; ai/init.lua first
  block labeled "Copilot" but is ChatGPT; git/init.lua resolve_conflicts comment says
  Gdiffsplit but runs Gvdiffsplit.
- [ ] **Modernize foldexpr** — `options.lua:64` `nvim_treesitter#foldexpr()` →
  `v:lua.vim.treesitter.foldexpr()`.
- [ ] **Invalid diagnostic float key** — `options.lua:152` `show_header` is not a valid
  key (silent no-op); real key is `header`.
- [ ] **Standardize mason `ensure_installed` idiom** — written 3 ways across
  `lsp/bash.lua`, `lsp/latex.lua`, `lsp/ansible.lua`.
- [ ] **Other inconsistencies**: `formatoptions:remove "o"` vs `:remove("o")`;
  `dirs` vs `cwd` in `pickers/files.lua`.

---

## Notes

- `luacheck` passes clean (0 warnings / 60 files) — these are semantic issues lint
  can't catch.
- API hygiene is otherwise modern: no `nvim_buf_set_option`, `vim.highlight`,
  `client.supports_method`, or `require("lspconfig").setup` deprecations found.
