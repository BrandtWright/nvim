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
    opts = function()
      local toggle_config = {
        id = "grammar_checker",
        name = "Grammar Checker",
        get = function()
          return #vim.lsp.get_clients({ name = "harper_ls", bufnr = 0 }) > 0
        end,
        set = function(state)
          if state then
            vim.lsp.enable("harper_ls")
            vim.api.nvim_exec_autocmds("FileType", { buffer = 0, modeline = false })
          else
            for _, client in ipairs(vim.lsp.get_clients({ name = "harper_ls" })) do
              client:stop()
            end
            vim.lsp.enable("harper_ls", false)
          end
        end,
      }
      Snacks.toggle.new(toggle_config):map("<leader>uR")
    end,
  },
}
