-- Deliberate inversion of LazyVim's defaults: buffer diagnostics sit on the
-- easier lowercase <leader>sd (the more frequent lookup) and the workspace view
-- on <leader>sD. Kept here -- not a redundant copy of the defaults.
return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>sd",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Diagnostics (Buffer)",
      },
      {
        "<leader>sD",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics (Workspace)",
      },
    },
  },
}
