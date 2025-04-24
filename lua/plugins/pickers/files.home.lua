return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fh",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fn.expand("~"),
          })
        end,
        desc = "Files (Home Directory)",
      },
      {
        "<leader>fH",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fn.expand("~"),
            hidden = true,
          })
        end,
        desc = "All Files (Home Directory)",
      },
    },
  },
}
