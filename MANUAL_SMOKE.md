# Manual Smoke Tests — Section 2 fixes

The headless harness (`tests/`) runs against nvim 0.12.3 with **no real plugins
loaded**. These checks cover what it can't: the actual plugins, your real nvim
version, and end-to-end behavior. Run them once in your normal nvim.

Status: **all complete and passing** (confirmed in-editor).

- [x] **Diagnostics virtual-text toggle** (commit a7c54ea)
  Open a file with diagnostics. Press `<leader>udv` to toggle virtual text off,
  then on again. Confirm: it actually toggles, and when re-enabled your
  configured prefix/format returns (not a bare default). `<leader>udd` still
  toggles all diagnostics.

- [x] **git pickers honor cwd** (commit 3d6d4ee)
  From a buffer, run `<leader>gf` (files), `<leader>gca` (commits), `<leader>gs`
  (status). Confirm results come from the intended repo. Try from a path with a
  space in it if you have one. Outside a repo, confirm you get the warning toast.

- [x] **picker meta-pickers** (commit 7df12b6)
  `<leader>lpa` (actions), `<leader>lpf` (format), `<leader>lpl` (layouts),
  `<leader>lpp` (preview) all open. (No startup error from picker.lua.)

- [x] **floating terminal opens in live cwd** (commit 156f400)
  `:cd` somewhere different, then toggle the terminal (`<c-_>`). Confirm the
  shell starts in the current directory, not nvim's startup directory.

- [x] **colorizer (catgoose fork) works + toggles** (commits 997407e, 172b13c)
  First run `:Lazy sync` to install `catgoose/nvim-colorizer.lua` and remove the
  old `norcalli` one. Then open a file with hex colors (e.g. `#ff0000`) or
  `colors/spf.lua`: confirm swatches appear, and that `:ColorizerToggle` now
  cleanly turns highlighting OFF and ON (the reason for the switch).

- [x] **slipbox save** (commit 1858e2e)
  Open a slip (`<leader>on` / `SlipEdit`), edit, `:w`. Confirm it saves via
  `snote -s` (no "Invalid slipbox file path" error). Especially if your slipbox
  dir contains `-`, `.`, or `~`.

- [x] **slips picker** (commit ff64b20)
  `<leader>sn` opens the slipbox picker; `<enter>` opens the selected slip.
  Inside a slip, `<localleader>a` (slip_links) still inserts a link line.

- [x] **ft-scoped keys are buffer-local** (commit 2c3ae77 — false-positive guard)
  Confirm `q` records a macro normally in a regular buffer (is NOT mapped to
  `:q`). `<leader>gp`/`<leader>gP` (pull/push) only exist in fugitive buffers.
  Note: the dead fm-nvim `q` map was removed (commit 80f71db); vifm is closed
  the standard vifm way (quit from within → fm-nvim's on_exit closes the float).

---

## Cleanup when the whole list is done

- `tests/` + `tests/run.sh` + `.gitignore` entry are committed (keep — useful).
- `.tests-deps/` (cloned plenary + lazy.nvim) is gitignored; delete anytime.
- nvim 0.12.3 was installed at `/opt/nvim` + `/usr/local/bin/nvim` for the
  sandbox harness; unrelated to your real install.
- Delete `TODO_LIST.md` and this file once Sections 3-5 are also done.
