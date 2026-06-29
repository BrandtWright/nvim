return {
  {
    -- Diagnostic display. Set here (not in config/options.lua) so it merges with
    -- LazyVim's defaults: LazyVim applies vim.diagnostic.config() during LSP
    -- setup, which would override anything set earlier in options.lua.
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "single",
        },
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    -- Registered in the snacks spec (not config/keymaps.lua) so the Snacks
    -- global is guaranteed loaded here. `opts`, not `config`: overriding config
    -- would clobber LazyVim's Snacks.setup. The toggle's save/restore logic
    -- lives in the pure bw.util.diagnostics builder so it stays unit-testable.
    opts = function()
      Snacks.toggle.new(require("bw.util.diagnostics").virtual_text_toggle()):map("<leader>udv")
      Snacks.toggle.diagnostics():map("<leader>udd")
    end,
  },
}
