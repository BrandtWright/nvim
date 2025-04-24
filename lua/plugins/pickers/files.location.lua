return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fl",
        function()
          local cwd = vim.fn.input("Directory", "", "dir")
          if cwd and cwd ~= "" then
            require("telescope.builtin").find_files({
              cwd = cwd,
            })
          end
        end,
        desc = "Files (Location Picker)",
      },
      {
        "<leader>fL",
        function()
          local cwd = vim.fn.input("Directory", "", "dir")
          if cwd and cwd ~= "" then
            require("telescope.builtin").find_files({
              cwd = cwd,
              hidden = true,
            })
          end
        end,
        desc = "All Files (Location Picker)",
      },
    },
  },
}
