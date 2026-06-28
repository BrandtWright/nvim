return {
  ------------------------------------------------------------------------------
  -- Copilot
  ------------------------------------------------------------------------------

  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    cmd = { "Copilot" },

    opts = {
      panel = { enabled = false },
      suggestion = {
        enabled = false,

        auto_trigger = false,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = "<M-y>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        ["*"] = false,
        markdown = false,
      },
    },
    keys = {
      {
        "<leader>uo",
        "<cmd>Copilot! toggle<cr>",
        desc = "Toggle Copilot",
      },
    },
  },
}
