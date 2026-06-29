--- Enable grammar checking and toggle with leader<uR>
return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "harper-ls")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        harper_ls = {
          filetypes = { "markdown", "tex" },
          settings = {
            ["harper-ls"] = {
              linters = {
                SpellCheck = false,
                ToDoHyphen = false,
              },
            },
          },
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    -- Registered in the snacks spec (not config/keymaps.lua) so the Snacks
    -- global is guaranteed loaded here. The enable/disable logic lives in the
    -- pure bw.util.grammar builder so it stays unit-testable.
    opts = function()
      Snacks.toggle.new(require("bw.util.grammar").checker_toggle()):map("<leader>uR")
    end,
  },
}
