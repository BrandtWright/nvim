return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>rt",
        function()
          local file_type = vim.fn.input("Type: ")
          if file_type and file_type ~= "" then
            Snacks.picker.grep({
              file_type = file_type,
            })
          end
        end,
        desc = "File Type",
      },
    },
  },
}
