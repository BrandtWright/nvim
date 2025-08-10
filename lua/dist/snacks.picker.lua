--------------------------------------------------------------------------------
-- Picker
--------------------------------------------------------------------------------
local picker = require("snacks").picker
return {
  {
    "folke/snacks.nvim",
    opts = function()
      -- Update hilights when colorscheme changes
      local grp = vim.api.nvim_create_augroup("SnacksHighlights", { clear = true })
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = grp,
        pattern = "*",
        callback = function()
          vim.cmd("hi! link SnacksPickerMatch Match")
          vim.cmd("hi! link SnacksPickerListCursorline PmenuSel")
        end,
        desc = "Reapply MyPlugin highlight groups after colorscheme changes",
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
