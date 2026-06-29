return {
  -- A former nvim-treesitter spec here tried to disable highlighting on files
  -- over 5MB with `highlight.disable = function(...) end`. It never ran: LazyVim
  -- tracks the nvim-treesitter `main` branch, where `highlight.disable` is a
  -- list of languages (string[]), not a predicate -- so the function was dead.
  -- Snacks.bigfile (LazyVim's big-file handler) adjusts syntax/animation but
  -- does not stop treesitter, so size-gated treesitter would have to be wired
  -- through Snacks.bigfile. Dropped the dead code rather than leave it looking
  -- active; bw.util.fs.buff_exceeds_size stays (it's still unit-tested).
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>cs", false }, -- Symbols (Trouble)
    },
  },
}
