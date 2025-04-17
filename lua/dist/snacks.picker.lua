--------------------------------------------------------------------------------
-- Picker
--------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    opts = function()
      vim.cmd("hi! link SnacksPickerMatch Match")
      vim.cmd("hi! link SnacksPickerListCursorline CursorLine")
    end,
    keys = {
      {
        "<leader>sa",
        function()
          require("snacks").picker.autocmds()
        end,
        desc = "Auto Commands",
      },
      {
        "<leader>s'",
        function()
          require("snacks").picker.registers()
        end,
        desc = "Registers",
      },
      {
        "<leader>sk",
        function()
          require("snacks").picker.keymaps()
        end,
        desc = "Key Maps",
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
        "<leader>sL",
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
