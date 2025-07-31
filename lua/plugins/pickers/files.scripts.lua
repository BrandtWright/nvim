return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>fs",
        function()
          Snacks.picker.files({
            dirs = { vim.fn.expand("~/.local/bin") },
          })
        end,
        desc = "Scripts",
      },
    },
  },
}
