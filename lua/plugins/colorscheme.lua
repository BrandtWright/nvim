require("bw.config.highlights").setup()

return {
  {
    "tjdevries/colorbuddy.nvim",
    priority = 10000,
    lazy = false,
  },
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = "screen_glasses"
    end,
  },
}
