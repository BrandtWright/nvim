return {
  ------------------------------------------------------------------------------
  -- Copilot
  --
  -- Available but dormant: Copilot costs money, so nothing is requested
  -- automatically. It is kept out of the completion menu (vim.g.ai_cmp = false,
  -- set in lua/config/options.lua) and inline suggestions are on-demand only:
  --
  --   <M-]>        request / cycle the next suggestion now (no auto-trigger)
  --   <M-[>        previous suggestion
  --   <M-y>        accept the shown suggestion
  --   <C-]>        dismiss
  --   <leader>uo   toggle continuous auto-suggestions for the current buffer
  --
  -- With auto_trigger off (the default below) Copilot makes a request only when
  -- you explicitly ask via <M-]> or flip the <leader>uo toggle -- so it never
  -- burns tokens just by typing or opening the completion menu.
  ------------------------------------------------------------------------------
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    cmd = { "Copilot" },
    event = "InsertEnter", -- load when typing so the inline keymaps are live
    opts = {
      panel = { enabled = false },
      suggestion = {
        enabled = true, -- module on, but...
        auto_trigger = false, -- ...no automatic requests; trigger/toggle on demand
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
    },
    keys = {
      {
        "<leader>uo",
        function()
          require("copilot.suggestion").toggle_auto_trigger()
        end,
        desc = "Toggle Copilot Auto-Suggest (buffer)",
      },
    },
  },
}
