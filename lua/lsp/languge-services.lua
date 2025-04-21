return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.cmd("hi! link LspInfoBorder FloatBorder")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {

        -- TODO: Compare with current lazyvim implementation (Snacks.bigfile)

        disable = function(_, buf)
          if require("bw.util.fs").buff_exceeds_size(buf, 1024 * 1024 * 5) then
            vim.notify("Treesitter disabled due to file size")
            return true
          end
        end,
      },
    },
  },
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>cs", false }, -- Symbols (Trouble)
    },
  },
}
