local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    --{ import = "lazyvim.plugins.extras.editor.symbols-outline" },
    { import = "lazyvim.plugins.extras.lang.omnisharp" },
    { import = "lazyvim.plugins.extras.lang.terraform" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.ui.mini-indentscope" },
    { import = "lazyvim.plugins.extras.coding.copilot" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.editor.harpoon2" },
    { import = "plugins" },
    { import = "user" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  ui = {
    border = "single",
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
local c = require("bw.config.colors")
vim.g.terminal_color_0 = c.black -- black
vim.g.terminal_color_1 = c.red -- red
vim.g.terminal_color_2 = c.green -- green
vim.g.terminal_color_3 = c.yellow -- yellow
vim.g.terminal_color_4 = c.blue -- blue
vim.g.terminal_color_5 = c.magenta -- magenta
vim.g.terminal_color_6 = c.cyan -- cyan
vim.g.terminal_color_7 = c.white -- white

vim.g.terminal_color_8 = c.bright_black -- black
vim.g.terminal_color_9 = c.bright_red -- red
vim.g.terminal_color_10 = c.bright_green -- green
vim.g.terminal_color_11 = c.bright_yellow -- yellow
vim.g.terminal_color_12 = c.bright_blue -- blue
vim.g.terminal_color_13 = c.bright_magenta -- magenta
vim.g.terminal_color_14 = c.bright_cyan -- cyan
vim.g.terminal_color_15 = c.bright_white -- white
