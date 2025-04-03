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
      {
        "<leader>si",
        function()
          require("snacks").picker.icons({ layout = { preview = false, preset = "dropdown" } })
        end,
        desc = "Icons",
      },
      {
        "<leader>cs",
        function()
          require("snacks").picker.lsp_symbols()
        end,
        desc = "Symbols (Document)",
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
    },
  },
}
