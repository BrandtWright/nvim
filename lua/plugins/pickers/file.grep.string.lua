return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>ro",
        function()
          require("telescope.builtin").grep_string({
            shorten_path = true,
            search = vim.fn.input("Grep String: "),
          })
        end,
        desc = "Other Strint",
      },
    },
  },
}
