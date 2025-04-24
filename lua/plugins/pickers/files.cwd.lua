return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>ff",
        require("telescope.builtin").find_files,
        desc = "Find Files (CWD)",
      },
      {
        "<leader>fF",
        function()
          require("telescope.builtin").find_files({
            hidden = true,
          })
        end,
        desc = "Find All Files (CWD)",
      },
    },
  },
}
