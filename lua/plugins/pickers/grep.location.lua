return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>rl",
        function()
          local dir = vim.fn.input("Directory: ", "", "dir")
          if dir and dir ~= "" then
            Snacks.picker.grep({ dirs = { dir } })
          end
        end,
        desc = "From Location",
      },
    },
  },
}
