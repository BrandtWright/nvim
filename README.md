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
