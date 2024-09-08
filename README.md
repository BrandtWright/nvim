# LazyVim Configuration WIP

## TODO

- Cyan is pretty washed out in source code. See: `./lua/bw/config/highlights/common.lua`
- Readme Keymap

    ```lua
    local proj_root = LazyVim.root.get()
    vim.cmd("edit " .. proj_root .. "README.md")
    ```

## Blacklist

- Sort out blacklist
  - Key Binds
    - LazyVim/LazyVim
    - Lazy/config/keymaps.lua
    - Plugins
  - Plugins
    - bufferline.nvim
    - vim-illuminate
    - flash.nvim
    - nvim-spectre

## Tresitter

- Setup better motion key maps for [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
  - Better change-in-function, delete-in-function, etc.

### AI

- Check out Codium

### Dev Helpers

- Check out Navic

### Implement Large File Perf Guards

See: [Reddit Post](https://tinyurl.com/mp9sxtew)

Maybe start with illuminate and miniindentscope disabeed by default and
create a key toggle to turn each on when needed...

Need something like:

```lua
local aug = vim.api.nvim_create_augroup("buf_large", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre" }, {
  callback = function()
    local ok, stats = pcall(
      vim.uv.fs_stat,
      vim.api.nvim_buf_get_name(
        vim.api.nvim_get_current_buf()
      )
    )
    if ok and stats and (stats.size > 1000000) then
      vim.b.large_buf = true
      vim.cmd("syntax off")
      vim.cmd("IlluminatePauseBuf") -- disable vim-illuminate
      vim.cmd("IndentBlanklineDisable") -- disable indent-blankline.nvim
      (vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
    else
      vim.b.large_buf = false
    end
  end,
  group = aug,
  pattern = "*",
})
```

This will disable ***some*** stuff but LSP should be disabled as well
(lsp_config on_attach)

## Clean Up

- TODO:
  - Colors
    - Better default terminal colors
      - Console integration
        - .Xresources
        - .taskrc (taskwarrior)
        - git plugins compatible with delta pager, git tools
      - Ansible integration
      - git plugins - fugitive, etc.)
  - Determine if `package.loaded[modname]` is better than `pcall(require, ...))`
    - See `:h package.loaded()` for details
  - Plugins
    - Check out `:LazyExtras` for additional language support and useful plugins
    - Integrate project with persistence for better session management
    - Fix git colors (diff/fugitive/gitsigns/etc.)
    - Customize Status Line
    - Make treesitter conceal bullets bigger for markdown
  - Not Plugins
    - Fix `~/.local/bin/zet` so that it doesn't create files and refactor nvim
      keymaps to `:e` the `path + isosec`
