--------------------------------------------------------------------------------
-- Picker
--------------------------------------------------------------------------------
local c = require("bw.config.colors")
local highlights = require("bw.config.highlights")
highlights.register({
  { name = "SnacksPickerMatch", fg = c.green },
  { name = "SnacksPickerListCursorline", bg = c.cursorline },
})

return {
  {
    "folke/snacks.nvim",
    keys = {
      -- Disable `gs` as it interferes with fugitive when not disabled explicitly.
      -- If this keybind is used before a ":Git" command is run fugitive will not be
      -- loaded and the map will default to snacks.git_status. Disabling the snacks
      -- keybind explicitly prevents the conflict.
      { "<leader>gs", false },
      {
        "<leader>sa",
        function()
          require("snacks").picker.autocmds()
        end,
        desc = "Auto Commands",
      },
      {
        "<leader>si",
        function()
          require("snacks").picker.icons({ layout = { preview = false, preset = "dropdown" } })
        end,
        desc = "Icons",
      },
      {
        "<leader>sd",
        function()
          require("snacks").picker.diagnostics_buffer()
        end,
        desc = "Diagnostics (Buffer)",
      },
      {
        "<leader>sD",
        function()
          require("snacks").picker.diagnostics()
        end,
        desc = "Diagnostics (Workspace)",
      },
      {
        "<leader>ss",
        function()
          require("snacks").picker.lsp_symbols()
        end,
        desc = "LSP Symbols (Document)",
      },
      {
        "<leader>sS",
        function()
          require("snacks").picker.lsp_workspace_symbols()
        end,
        desc = "LSP Symbols (Workspace)",
      },
      {
        "<leader>sH",
        function()
          require("snacks").picker.highlights()
        end,
        desc = "Highlights",
      },
      {
        "<leader>fS",
        function()
          require("snacks").picker.lsp_config()
        end,
        desc = "LSP Config",
      },
      {
        "<leader>lpa",
        function()
          require("snacks").picker.picker_actions()
        end,
        desc = "Actions",
      },
      {
        "<leader>lpf",
        function()
          require("snacks").picker.picker_format()
        end,
        desc = "Format",
      },
      {
        "<leader>lpl",
        function()
          require("snacks").picker.picker_layouts()
        end,
        desc = "Layouts",
      },
      {
        "<leader>lpp",
        function()
          require("snacks").picker.picker_preview()
        end,
        desc = "Preview",
      },
    },
  },
}
