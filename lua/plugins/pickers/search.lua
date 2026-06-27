-------------------------------------------------------------------------------
-- Fuzzy find over autocommands
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",

    -- stylua: ignore
    keys = {
      { "<leader>srt", function() Snacks.picker.resume() end, desc = "Resume Picker" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Auto Commands" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History", },
      { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands", },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jump List" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Key Maps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>srs", function() Snacks.picker.resume() end, desc = "Snacks Picker" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>s'", function() Snacks.picker.registers() end, desc = "Registers" },
      { "z=", function() Snacks.picker.spelling() end, desc = "Spelling Suggestions", },
    },
  },
}
