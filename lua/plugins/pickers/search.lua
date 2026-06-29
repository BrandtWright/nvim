-------------------------------------------------------------------------------
-- Search pickers that DEVIATE from LazyVim's snacks_picker defaults. The maps
-- identical to LazyVim's (sa, :, sh, sH, sj, sk, sl, sM, sm, sq) were dropped --
-- LazyVim provides them via the snacks_picker extra. That extra is NOT
-- auto-enabled here: this config's lazyvim.json `install_version` is 7 (pre-v8),
-- so LazyVim's grandfather rule defaults the picker to fzf and never imports
-- snacks_picker's maps. `vim.g.lazyvim_picker = "snacks"` in config/options.lua
-- opts back in -- without it, the dropped maps silently vanish.
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
