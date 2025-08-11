--------------------------------------------------------------------------------
-- Picker
--------------------------------------------------------------------------------
local picker = require("snacks").picker
return {
  {
    "folke/snacks.nvim",
    opts = function()
      local apply_highlights = function()
        vim.cmd("hi! link SnacksPickerMatch Match")
        vim.cmd("hi! link SnacksPickerListCursorline PmenuSel")
      end

      -- apply highlights now
      apply_highlights()

      -- Update hilights when colorscheme changes
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("SnacksHighlights", { clear = true }),
        pattern = "*",
        callback = apply_highlights,
        desc = "Reapply snacks highlight groups after colorscheme changes",
      })
    end,
    keys = {
      { "<leader>lpa", picker.picker_actions, desc = "Actions" },
      { "<leader>lpf", picker.picker_format, desc = "Format" },
      { "<leader>lpl", picker.picker_layouts, desc = "Layouts" },
      { "<leader>lpp", picker.picker_preview, desc = "Preview" },
    },
  },
}
