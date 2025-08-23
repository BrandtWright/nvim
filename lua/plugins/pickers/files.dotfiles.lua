return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>f.",
        function()
          Snacks.picker.files({
            finder = function()
              local dotfiles = vim.fn.systemlist("dotfiles")
              local items = {}
              for _, v in ipairs(dotfiles) do
                table.insert(items, {
                  file = v,
                  text = v,
                })
              end
              return items
            end,
          })
        end,
        desc = "Dotfiles",
      },
    },
  },
}
