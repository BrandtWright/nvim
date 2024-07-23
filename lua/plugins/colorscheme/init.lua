require("bw.config.highlights").setup()

return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy_load = false,
    load_priority = 10000,
  },
  {
    "LazyVim/LazyVim",
    dependencies = {
      "ellisonleao/gruvbox.nvim",
    },
    opts = function(_, opts)
      opts.colorscheme = "gruvbox"
    end,
  },
}
