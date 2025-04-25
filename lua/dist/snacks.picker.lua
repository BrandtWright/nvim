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
      { "<leader>sd", picker.diagnostics_buffer, desc = "Diagnostics (Buffer)" },
      { "<leader>sD", picker.diagnostics, desc = "Diagnostics (Workspace)" },
      { "<leader>ss", picker.lsp_symbols, desc = "LSP Symbols (Document)" },
      { "<leader>sS", picker.lsp_workspace_symbols, desc = "LSP Symbols (Workspace)" },
      { "<leader>sH", picker.highlights, desc = "Highlights" },
      { "<leader>sL", picker.lsp_config, desc = "LSP Config" },
      { "<leader>lpa", picker.picker_actions, desc = "Actions" },
      { "<leader>lpf", picker.picker_format, desc = "Format" },
      { "<leader>lpl", picker.picker_layouts, desc = "Layouts" },
      { "<leader>lpp", picker.picker_preview, desc = "Preview" },
      {
        "<leader>si",
        function()
          require("snacks").picker.icons({ layout = { preview = false, preset = "dropdown" } })
        end,
        desc = "Icons",
      },
    },
  },
}
