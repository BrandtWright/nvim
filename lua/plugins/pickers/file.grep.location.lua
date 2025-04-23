return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>rl",
        function()
          local cwd = vim.fn.input("Directory: ", "", "dir")
          if cwd and cwd ~= "" then
            local opts = {
              vimgrep_arguments = {
                cwd = cwd,
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                vim.fn.input("Type: "),
              },
            }
            require("telescope.builtin").live_grep(opts)
          end
        end,
        desc = "From Location",
      },
    },
  },
}
