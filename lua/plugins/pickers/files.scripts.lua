return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fs",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fn.expand("~/.local/bin"),
          })
        end,
        desc = "Scripts",
      },
    },
  },
}
