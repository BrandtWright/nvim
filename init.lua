local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.lang.ansible" },
    { import = "lazyvim.plugins.extras.lang.dotnet" },
    { import = "lazyvim.plugins.extras.lang.haskell" },
    { import = "lazyvim.plugins.extras.lang.terraform" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.ai.copilot" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.editor.harpoon2" },
    -- Import topology. `import = "plugins"` pulls in every top-level
    -- lua/plugins/*.lua, plus the `init.lua` of any *subdirectory* that has one
    -- -- it does NOT enumerate other loose files inside a subdir. That single
    -- rule explains the layout convention here:
    --   * plugins/git/ and plugins/ai/ each have an init.lua, so they are
    --     auto-imported by the line below. A loose non-spec module like
    --     plugins/git/api.lua is therefore SAFE to sit beside that init.lua:
    --     lazy only pulls the subdir's init.lua, so api.lua is never mistaken
    --     for a plugin spec.
    --   * plugins/pickers/ and plugins/lang/ are bags of independent specs with
    --     NO init.lua, so `import = "plugins"` skips them -- hence the two
    --     explicit imports below. They are required, not redundant.
    -- Convention: a cohesive feature gets a subdir + init.lua (auto-imported); a
    -- collection of unrelated specs gets loose files + an explicit import here.
    { import = "plugins" },
    { import = "plugins/pickers" },
    { import = "plugins/lang" },
  },
  defaults = {
    -- Every custom plugin in this config sets its own trigger (event/cmd/ft/keys)
    -- or an explicit `lazy` flag, so this default is currently inert -- nothing
    -- relies on it. Kept `false` (LazyVim's recommendation): a future plugin added
    -- without a trigger then loads eagerly and WORKS, rather than silently never
    -- loading until something require()s it.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  ui = {
    border = "single",
  },
  -- install = { colorscheme = { "tokyonight", "habamax" } },
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
