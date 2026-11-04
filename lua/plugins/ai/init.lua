return {
  ------------------------------------------------------------------------------
  -- Copilot
  --
  -- Off by default in every buffer and filetype. <leader>uo attaches Copilot to
  -- the current buffer and enables automatic inline suggestions there; pressing
  -- it again detaches. Copilot stays out of the completion menu (vim.g.ai_cmp =
  -- false, set in lua/config/options.lua).
  --
  --   <leader>uo   attach to / detach from the current buffer
  --
  -- Insert-mode keymaps, present only while attached:
  --
  --   <M-]>        request / cycle the next suggestion
  --   <M-[>        previous suggestion
  --   <M-y>        accept the shown suggestion
  --   <C-]>        dismiss
  --
  -- should_attach rejects every non-forced attach, which blocks the plugin's
  -- automatic attach paths (buffer enter, suggestion request, rename). The toggle
  -- uses `:Copilot! attach`, which bypasses should_attach and the filetype rules.
  --
  -- The plugin and its language server start on the first toggle, and the server
  -- runs until Neovim exits. Renaming a buffer or changing its filetype detaches
  -- it; the toggle flag stays set, so reattaching takes two presses.
  --
  -- LazyVim's lualine component shows the Copilot icon only for attached buffers.
  ------------------------------------------------------------------------------
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    cmd = { "Copilot" },
    -- A function replaces the event list. A plain value would merge with the
    -- BufReadPost from LazyVim's Copilot extra.
    event = function()
      return {}
    end,
    opts = {
      should_attach = function()
        return false
      end,
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = false, -- enabled per buffer by <leader>uo
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
          local buf = vim.api.nvim_get_current_buf()
          -- The flag, not the attach state: a client still initializing reads as detached.
          local on = not vim.b[buf].copilot_suggestion_auto_trigger
          vim.cmd(on and "Copilot! attach" or "Copilot detach")
          vim.b[buf].copilot_suggestion_auto_trigger = on
          vim.notify("Copilot " .. (on and "on" or "off") .. " for this buffer")
        end,
        desc = "Toggle Copilot (buffer)",
      },
    },
  },
}
