-------------------------------------------------------------------------------
-- Fuzzy find spelling suggestions
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "z=",
        function()
          local themes = require("telescope.themes")
          local opts = themes.get_dropdown({
            winblend = 10,
            border = true,
            previewer = false,
            layout_config = {
              width = 0.5,
            },
          })
          require("telescope.builtin").spell_suggest(opts)
        end,
        mode = "n",
        desc = "Spelling Suggestions",
      },
    },
  },
}
