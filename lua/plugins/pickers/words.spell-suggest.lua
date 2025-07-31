-------------------------------------------------------------------------------
-- Fuzzy find spelling suggestions
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "z=",
        Snacks.picker.spelling,
        desc = "Spelling Suggestions",
      },
    },
  },
}
