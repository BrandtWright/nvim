# Neovim Configuration

My Neovim config. I wouldn't recommend trying to get this to work on your
system as is but feel free to take what you can from it.

## Requirements

- **Neovim ≥ 0.10** (uses `vim.uv`, `vim.system`, `vim.treesitter.foldexpr`, etc.)
- **`git`**, **`ripgrep`** (`rg`), and **`fd`** — for plugin management and pickers.

Optional, enabling specific features:

- **`xrdb`** — source of the `spf` colorscheme palette (falls back to baked-in
  colors if absent).
- **[`snote`][snote]** — required by the slipbox (`:SlipNew` / `:SlipEdit` / save).
- **`dict`**, **`pandoc`** + **`zathura`** — used by individual
  keymaps/ftplugins (dictionary lookup, markdown export).

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
- `markdownlint-cli2 '**/*.md'` — Markdown linting.

[snote]: https://github.com/BrandtWright/slipbox
