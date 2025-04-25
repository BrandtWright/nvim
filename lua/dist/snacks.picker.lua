--------------------------------------------------------------------------------
-- Picker
--------------------------------------------------------------------------------
local picker = require("snacks").picker
return {
  {
    "folke/snacks.nvim",
    opts = function()
      vim.cmd("hi! link SnacksPickerMatch Match")
      vim.cmd("hi! link SnacksPickerListCursorline PmenuSel")
    end,
    keys = {
      { "<leader>lpa", picker.picker_actions, desc = "Actions" },
      { "<leader>lpf", picker.picker_format, desc = "Format" },
      { "<leader>lpl", picker.picker_layouts, desc = "Layouts" },
      { "<leader>lpp", picker.picker_preview, desc = "Preview" },
    },
  },
}
