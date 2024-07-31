return {
  {
    "norcalli/nvim-colorizer.lua",
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "single",
        height = 0.8,
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        -- add a border to hover docs and signature help
        lsp_doc_border = "single",
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      exclude = {
        filetypes = {
          "markdown",
          "dashboard",
          "Fm",
          "terminal",
          "lazyterm",
        },
      },
    },
  },
}
