-------------------------------------------------------------------------------
-- Fuzzy find over autocommands
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly key: autocommands are handled by snacks
      { "<leader>sa", false },
      -- silly key: command history is handled by snacks
      { "<leader>:", false },
      -- silly key: command history is handled by snacks
      { "<leader>sc", false },
      -- silly key: commands are handled by snacks
      { "<leader>sC", false },
      -- silly key: pages are handled by snacks
      { "<leader>sh", false },
      -- silly key: highlight groups  are handled by snacks
      { "<leader>sH", false },
      -- silly key: jumps are handled by snacks
      { "<leader>sj", false },
      -- silly key: key maps are handled by snacks
      { "<leader>sk", false },
      -- silly key: location list is handled by snacks
      { "<leader>sl", false },
      -- silly key: man pages are handled by snacks
      { "<leader>sM", false },
      -- silly key: marks are handled by snacks
      { "<leader>sm", false },
      -- silly key: moved to leader_s_r_t
      { "<leader>sR", false },
      -- silly key: quickfixes are handled by snacks
      { "<leader>sq", false },
      -- silly key: registers are handled by snacks
      { '<leader>s"', false },

      -- resume telescope
      -- stylua: ignore
      { "<leader>srt", function() require("telescope.builtin").resume() end, desc = "Telescope Picker", },
    },
  },
  {
    "folke/snacks.nvim",

    -- stylua: ignore
    keys = {
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
