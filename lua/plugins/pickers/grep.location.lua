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
              cwd = "/home/brandt/repos/Rigel/",
              vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
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
