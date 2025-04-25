-------------------------------------------------------------------------------
-- Fuzzy find over icons
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>si",
        function()
          Snacks.picker.icons({ layout = { preview = false, preset = "dropdown" } })
        end,
        desc = "Icons",
      },
    },
  },
}
