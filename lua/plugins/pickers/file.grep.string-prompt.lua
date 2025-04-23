return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>rs",
        require("telescope.builtin").grep_string,
        desc = "String",
      },
    },
  },
}
