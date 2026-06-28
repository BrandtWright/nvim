# Neovim Configuration

A personal Neovim setup built on [LazyVim](https://www.lazyvim.org/), with a
custom xresources-driven colorscheme, an all-[snacks.nvim](https://github.com/folke/snacks.nvim)
picker layer, a [Zettelkasten](https://en.wikipedia.org/wiki/Zettelkasten)-style
"slipbox", and a small library of utilities under the `bw/` namespace.

## Highlights

- **LazyVim base** with language extras for Ansible, .NET, Docker, Haskell,
  JSON, Markdown, Python, Rust, Terraform, TypeScript, and YAML, plus Copilot,
  mini-surround, and Harpoon.
- **Custom colorscheme (`spf`)** — generated from your `xrdb` palette (via
  `bw.util.xresources`) with hardcoded fallbacks, so it renders correctly even
  without an X server. `screen_glasses` is an alternate scheme.
- **Snacks-only pickers** — telescope was removed as the picker; everything goes
  through `snacks.picker`. A directory of custom pickers lives in
  `lua/plugins/pickers/` (files, grep, LSP, git, slipbox, …).
- **Slipbox** — a note system backed by the external `snote` CLI: `:SlipNew`,
  `:SlipEdit`, related-note navigation, and a custom picker (`lua/user/slipbox/`).
- **Scratch buffers** — transient (`<leader>oS*`) and persistent
  (`<leader>os*`) scratch pads.
- **Tested** — a headless [plenary](https://github.com/nvim-lua/plenary.nvim)
  busted suite under `tests/`, runnable with `make test`.

## Requirements

- **Neovim ≥ 0.10** (uses `vim.uv`, `vim.system`, `vim.treesitter.foldexpr`).
- A **Nerd Font** (the fold/UI glyphs in `fillchars` are nerd-font characters).
- **git**, **ripgrep** (`rg`), and **fd** — for plugin management and pickers.

Optional, enabling specific features:

- **`xrdb`** — source of the `spf` colorscheme palette (falls back to baked-in
  colors if absent).
- **`snote`** — required by the slipbox (`:SlipNew` / `:SlipEdit` / save).
- **`lazygit`**, **`dict`**, **`pandoc`** + **`zathura`** — used by individual
  keymaps/ftplugins (git UI, dictionary lookup, markdown export).

## Layout

```text
init.lua              Entry point: bootstraps lazy.nvim, imports the spec
lua/
  config/             options, keymaps, autocmds, disabled "silly-keys"
  plugins/            plugin specs (pickers/, lsp/, git/, ai/, toggles/, …)
  bw/                 personal namespace
    util/             fs, highlights, xresources, scratch-buffer, …
    types/            functional types: Either, Maybe, List
  user/slipbox/       the slipbox note system
after/ftplugin/       filetype-local settings
colors/               spf + screen_glasses colorschemes
tests/                plenary specs + harness (run via `make test`)
Makefile              test runner (bootstraps a pinned plenary)
```

## Keybindings

Leader is `<Space>`. Keys are grouped by prefix (shown via which-key):

| Prefix | Group | | Prefix | Group |
| --- | --- | --- | --- | --- |
| `<leader>b` | Buffer | | `<leader>o` | Open (scratch, slipbox) |
| `<leader>c` | Code | | `<leader>r` | Grep |
| `<leader>f` | Find | | `<leader>s` | Search |
| `<leader>g` | Git | | `<leader>u` | UI / toggles |
| `<leader>h` | Harpoon | | `<leader>w` | Window |
| `<leader>m` | Terminal | | `<leader>x` | Lists |

See `lua/config/keymaps.lua` and the which-key `spec` in `lua/plugins/ui.lua`
for the full set.

## Testing

```bash
make test                          # run the whole suite
make test FILE=tests/fs_spec.lua   # run a single spec
make clean-deps                    # remove the cloned test deps
```

The suite needs only plenary, which `make` clones into the gitignored
`.tests-deps/` and pins to a known-good commit (matching `lazy-lock.json`).
Specs run headlessly, each in its own Neovim instance, and `require()` config
modules directly without booting lazy.nvim.

## Linting & formatting

- `luacheck .` — Lua linting (config in `.luacheckrc`).
- `stylua` — formatting (config in `stylua.toml`: 2 spaces, 120 columns).
