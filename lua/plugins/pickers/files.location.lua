return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>fl",
        function()
          local dir = vim.fn.input("Directory", "", "dir")
          if dir and dir ~= "" then
            Snacks.picker.files({
              dirs = { dir },
            })
          end
        end,
        desc = "Files (Location Picker)",
      },
      {
        "<leader>fL",
        function()
          local dir = vim.fn.input("Directory", "", "dir")
          if dir and dir ~= "" then
            Snacks.picker.files({
              dirs = { dir },
              hidden = true,
            })
          end
        end,
        desc = "All Files (Location Picker)",
      },
    },
  },
}
