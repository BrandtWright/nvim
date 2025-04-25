-------------------------------------------------------------------------------
-- Fuzzy find over highlight groups
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: highlight groups  are handled by snacks
      { "<leader>sH", false },
    },
  },
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
