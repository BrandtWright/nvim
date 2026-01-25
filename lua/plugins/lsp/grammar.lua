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
          filetypes = { "markdown", "gitcommit" },
          settings = {
            ["harper-ls"] = {
              linters = {
                SentenceCapitalization = false,
                SpellCheck = false,
              },
            },
          },
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = function()
      local toggle_config = {
        id = "grammar_checker",
        name = "Grammar Checker",
        get = function()
          return #vim.lsp.get_clients({ name = "harper_ls", bufnr = 0 }) > 0
        end,
        set = function(state)
          for _, client in ipairs(vim.lsp.get_clients({ name = "harper_ls" })) do
            if state then
              vim.lsp.buf_attach_client(0, client.id)
            else
              vim.lsp.buf_detach_client(0, client.id)
            end
          end
        end,
      }
      Snacks.toggle.new(toggle_config):map("<leader>uR")
    end,
  },
}
