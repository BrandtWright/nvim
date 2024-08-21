return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-symbols.nvim",
      "xiyaowong/telescope-emoji.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-lua/plenary.nvim",
    },
    keys = require("user.finders.keys"),
    opts = require("user.finders.opts"),
  },
}