-------------------------------------------------------------------------------
-- Resume Picker Operation
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {

      -- silly key: moved to leader_s_r_t
      { "<leader>sR", false },

      -- resume telescope
      { "<leader>srt", require("telescope.builtin").resume, desc = "Telescope Picker" },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>srs", Snacks.picker.resume, desc = "Snacks Picker" },
    },
  },
}
