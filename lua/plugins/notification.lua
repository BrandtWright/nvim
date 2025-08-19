return {
  {
    "folke/noice.nvim",
    opts = function()
      local function apply_highlights()
        vim.cmd("hi! link NoiceCmdlinePopupBorder Special")
        vim.cmd("hi! link NoiceCmdlineIcon Special")
        vim.cmd("hi! link NoiceCmdlinePopupTitle Special")
      end

      apply_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("NoiceHighlights", { clear = true }),
        pattern = "*",
        callback = apply_highlights,
        desc = "Reapply noice highlight groups after colorscheme changes",
      })
    end,
  },
  {
    "folke/snacks.nvim",
    opts = function()
      local function apply_highlights()
        local get_attr = require("bw.util.highlights").get_attribute
        local bg = get_attr("Normal", "bg")
        -- Error
        local error_fg = get_attr("DiagnosticError", "fg")
        vim.api.nvim_set_hl(0, "SnacksNotifierError", { fg = error_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierBorderError", { fg = error_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierIconError", { fg = error_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { fg = error_fg, bg = bg })
        -- Warn
        local warn_fg = get_attr("DiagnosticWarn", "fg")
        vim.api.nvim_set_hl(0, "SnacksNotifierWarn", { fg = warn_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierBorderWarn", { fg = warn_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierIconWarn", { fg = warn_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn", { fg = warn_fg, bg = bg })
        -- Info
        local info_fg = get_attr("DiagnosticInfo", "fg")
        vim.api.nvim_set_hl(0, "SnacksNotifierInfo", { fg = info_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierBorderInfo", { fg = info_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo", { fg = info_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo", { fg = info_fg, bg = bg })
        -- Ok
        local ok_fg = get_attr("DiagnosticOk", "fg")
        vim.api.nvim_set_hl(0, "SnacksNotifierOk", { fg = ok_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierBorderOk", { fg = ok_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierIconOk", { fg = ok_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierTitleOk", { fg = ok_fg, bg = bg })
        -- Hint
        local hint_fg = get_attr("DiagnosticHint", "fg")
        vim.api.nvim_set_hl(0, "SnacksNotifierHint", { fg = hint_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierBorderHint", { fg = hint_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierIconHint", { fg = hint_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierTitleHint", { fg = hint_fg, bg = bg })
      end

      apply_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("SnacksNotifierHighlights", { clear = true }),
        pattern = "*",
        callback = apply_highlights,
        desc = "Reapply snacks notifier highlight groups after colorscheme changes",
      })
    end,
  },
}
