# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Development Commands

### Linting

- `luacheck .` - Run Lua linting (luacheck is installed)
- Code formatting uses stylua configuration in `stylua.toml` (2 spaces, 120 columns)

### Testing

No test framework is present in this configuration.

## Architecture Overview

This is a comprehensive Neovim configuration built on top of LazyVim, featuring
custom plugins, utilities, and a modular architecture.

### Core Structure

#### Entry Point

- `init.lua` - Main configuration entry point that sets up Lazy plugin manager
and imports all modules

#### Configuration Core

- `lua/config/` - Core Neovim settings
  - `options.lua` - Vim options (leader key, colors, tabs, folding, etc.)
  - `keymaps.lua` - Custom keybindings and navigation
  - `autocmds.lua` - Autocommands
  - `silly-keys.lua` - Keys to disable

#### Plugin Architecture

- `lua/plugins/` - Plugin configurations organized by functionality
  - `colorscheme.lua` - Custom colorscheme setup (uses "spf" theme)
  - `completion.lua`, `navigation.lua`, `statusline.lua`, etc.
  - `pickers/` - Extensive custom picker configurations for telescope/snacks
  - `toggles/` - UI toggle functionality
  - `ai/` - AI integration (Copilot)
  - `git/` - Git-related plugins

#### Custom Utilities (`lua/bw/`)

- `bw/util/` - Custom utility modules
  - `scratch-buffer.lua` - Scratch buffer management
  - `highlights.lua`, `diagnostics.lua`, `fs.lua`, etc.
- `bw/types/` - Custom type definitions (either, maybe, list)

#### Language Support

- `after/ftplugin/` - Filetype-specific settings

#### Custom Features

- **Slipbox**: Personal knowledge management system (`lua/user/slipbox/`, `lua/plugins/slipbox.lua`)
  - Commands: `SlipNew`, `SlipEdit`
  - Directory: `~/data/base/slipbox`
  - Keybindings: `<leader>on` (new slip), `<leader>oN` (edit by ID)

### Key Features

#### Custom Colorschemes

- Primary: `spf` (colors/spf.lua)
- Alternative: `screen_glasses`

#### Extensive Picker System

- 30+ custom pickers in `lua/plugins/pickers/`
- Categories: files, grep, LSP, nvim internals, diagnostics
- Special pickers for slipbox, git workflows

#### Custom Keybinding Philosophy

- Leader key: Space
- Window management: `<leader>w*`
- Buffer operations: `<leader>b*`
- File operations: `<leader>f*`
- Scratch buffers: `<leader>oS*` (transient), `<leader>os*` (persistent)

#### Advanced Features

- Custom fold text function using Treesitter
- Tmux integration
- Zen mode with status bar toggling
- Custom diagnostic handling
- Scratch buffer system (transient and persistent)

## Development Practices

- Use 2-space indentation (configured in stylua.toml)
- Follow LazyVim conventions for plugin configuration
- Custom utilities go in `bw/` namespace
- Pickers are organized by category in separate files
- LSP configurations are language-specific in `lsp/` directory

## Additional Documentation

- Neovim Help Files
  - `/usr/share/nvim/runtime/doc/`
- [Snacks.nvim Documentation](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md)
- [LazyVim Documentation](https://www.lazyvim.org/)
