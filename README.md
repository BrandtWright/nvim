# Neovim Configuration

My Neovim config. I wouldn't recommend trying to get this to work on your
system as is but feel free to take what you can from it.

## Requirements

- **Neovim 0.12+** — CI-verified at `v0.12.3` (uses `vim.lsp.enable`,
  `vim.system`, `vim.treesitter.foldexpr`, etc.).
- **`git`**, **`ripgrep`** (`rg`), and **`fd`** — for plugin management and pickers.

Optional, enabling specific features:

- **`xrdb`** — source of the `spf` colorscheme palette (falls back to baked-in
  colors if absent).
- **[`snote`][snote]** — required by the slipbox (`:SlipNew` / `:SlipEdit` / save).
- **`dict`**, **`pandoc`** + **`zathura`** — used by individual
  keymaps/ftplugins (dictionary lookup, markdown export).

## Plugin versions & reproducibility

Plugins deliberately **float to upstream latest** — there is no committed
restore point, and that drift is an accepted cost.

- `defaults.version = false` (in `init.lua`) means each plugin resolves to its
  latest git commit, and `checker = { enabled = true }` surfaces updates.
- `lazy-lock.json` is **intentionally gitignored** (see `.gitignore`). It is
  written locally by lazy.nvim but never committed.

**Why accept the drift.** This config is edited and updated from more than one
machine. A committed `lazy-lock.json` would change on every `:Lazy update` on
every machine, so it would generate constant merge conflicts for no real
benefit. Pinning every plugin instead would trade those conflicts for staleness
— missing upstream fixes until each pin is manually bumped. Letting the set
float keeps maintenance near zero.

**What the drift costs.** There is no committed snapshot to `:Lazy restore` to,
so two checkouts (or this machine before and after an update) can resolve to
different plugin commits, and a bad upstream commit can land on an update. The
only restore point is the local, uncommitted lock; recovery is `:Lazy update`
(or rolling an individual plugin back by hand).

**What is *not* allowed to drift.** Reproducibility is spent where it actually
protects correctness — the verification tooling, not the running plugin set:

- The test suite's only dependency, **plenary, is pinned by commit SHA**
  (`PLENARY_REF` in the `Makefile`).
- **CI pins Neovim, luacheck, and stylua** to concrete versions
  (`.github/workflows/ci.yml`).

So the checks that decide whether the config is healthy are fully
deterministic, even though the plugins they run against are not.

## Copilot

GitHub Copilot is installed but **disabled by default**, and deliberately so:
it is a paid service, and the usual LazyVim setup wires it into the completion
menu — which means it fires a request *every time the popup opens*. That burns
tokens constantly in the background. This config avoids that:

- It is kept **out of the completion menu** (`vim.g.ai_cmp = false`).
- It runs as **inline suggestions only**, with auto-trigger **off**. In its
  default state Copilot makes **no requests at all** — typing and opening the
  completion menu never call it.

So nothing happens (and nothing is billed) until you explicitly ask for it.

**Authenticating.** The first time you use Copilot on a machine, sign in once:

```vim
:Copilot auth
```

**Turning it on and off.** Two levels of opt-in:

- **One suggestion, on demand** — request a single completion where the cursor
  is. This makes exactly one request and is the lightest way to use it.
- **Continuous suggestions** — `<leader>uo` toggles auto-suggestions for the
  *current buffer*. Flip it on for a stretch of active pairing, flip it back off
  when you're done. It is buffer-local, so it never silently stays on
  everywhere.

There is no global "always on" mode by design — the default is always dormant,
and you raise the level of assistance only when you want it.

See `lua/plugins/ai/init.lua` for the full keymap list and configuration.

## Testing

```bash
make test                          # run the whole suite
make test FILE=tests/fs_spec.lua   # run a single spec
make clean-deps                    # remove the cloned test deps
```

The suite needs only plenary, which `make` clones into the gitignored
`.tests-deps/` and pins to a known-good commit. Specs run headlessly, each in
its own Neovim instance, and `require()` config modules directly.

## Linting & formatting

- `luacheck .` — Lua linting (config in `.luacheckrc`).
- `stylua` — formatting (config in `stylua.toml`: 2 spaces, 120 columns).
  Use `-- stylua: ignore` to preserve a hand-formatted span.
- `markdownlint-cli2` — Markdown linting (globs/ignores in
  `.markdownlint-cli2.yaml`).

## Continuous integration

`.github/workflows/ci.yml` runs on every push to `main` and on pull requests:

- **test** — `make test` against a pinned Neovim.
- **lint** — `luacheck .` and `stylua --check .`, both pinned.
- **markdown** — `markdownlint-cli2`, pinned.

The pins (Neovim, luacheck, stylua, markdownlint-cli2, and plenary via the
`Makefile`) keep CI deterministic; bump them deliberately and re-run the
relevant check locally when you do.

[snote]: https://github.com/BrandtWright/slipbox
