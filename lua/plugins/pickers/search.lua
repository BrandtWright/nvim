-------------------------------------------------------------------------------
-- Search pickers that DEVIATE from LazyVim's snacks_picker defaults. The maps
-- identical to LazyVim's (sa, :, sh, sH, sj, sk, sl, sM, sm, sq) were dropped --
-- LazyVim already provides them via the auto-enabled snacks_picker default.
-- Kept below are the genuine deviations:
--   <leader>sc  -> Commands    (LazyVim's <leader>sc is Command History)
--   <leader>srs -> Resume      (LazyVim binds resume to <leader>sR)
--   <leader>s'  -> Registers   (LazyVim binds registers to <leader>s")
--   z=          -> Spelling    (not mapped by LazyVim)
-------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",

    -- stylua: ignore
    keys = {
      { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands", },
      { "<leader>srs", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>s'", function() Snacks.picker.registers() end, desc = "Registers" },
      { "z=", function() Snacks.picker.spelling() end, desc = "Spelling Suggestions", },
    },
  },
}
