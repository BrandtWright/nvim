--------------------------------------------------------------------------------
-- Indent
--------------------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- Disable indent guides in certain file types
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("DisableSnacksIndentGuides", { clear = true }),
        pattern = "markdown",
        callback = function()
          vim.b.snacks_indent = false
        end,
      })

      local my_opts = {
        indent = {
          enabled = false,
        },
      }

      return vim.tbl_deep_extend("force", opts or {}, my_opts)
    end,
  },
}
