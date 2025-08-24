return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              -- Override the default alt-h keymap for toggling hidden files
              ["<M-.>"] = "toggle_hidden",
              -- Disable the default alt-h keymap to avoid conflicts with TMUX
              ["<M-h>"] = false,
            },
          },
        },
      },
    },
  },
}
