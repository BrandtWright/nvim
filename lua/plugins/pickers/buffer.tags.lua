return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>bt",
        function()
          require("telescope.builtin").current_buffer_tags()
        end,
        desc = "Tags (CWD)",
      },
    },
  },
}
