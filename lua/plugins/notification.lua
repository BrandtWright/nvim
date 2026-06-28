local highlights = require("bw.util.highlights")

return {
  {
    "folke/noice.nvim",
    opts = function()
      highlights.on_colorscheme("NoiceHighlights", function()
        vim.cmd("hi! link NoiceCmdlinePopupBorder Special")
        vim.cmd("hi! link NoiceCmdlineIcon Special")
        vim.cmd("hi! link NoiceCmdlinePopupTitle Special")
      end)
    end,
  },
  {
    "folke/snacks.nvim",
    opts = function()
      highlights.on_colorscheme("SnacksNotifierHighlights", function()
        local get_attr = highlights.get_attribute
        local bg = get_attr("Normal", "bg")
        local fg = get_attr("Normal", "fg")
        -- Error
        local error_fg = get_attr("DiagnosticError", "fg")
        vim.api.nvim_set_hl(0, "SnacksNotifierError", { fg = fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierBorderError", { fg = error_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierIconError", { fg = error_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { fg = error_fg, bg = bg })
        -- Warn
        local warn_fg = get_attr("DiagnosticWarn", "fg")
        vim.api.nvim_set_hl(0, "SnacksNotifierWarn", { fg = fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierBorderWarn", { fg = warn_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierIconWarn", { fg = warn_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn", { fg = warn_fg, bg = bg })
        -- Info
        local info_fg = get_attr("DiagnosticInfo", "fg")
        vim.api.nvim_set_hl(0, "SnacksNotifierInfo", { fg = fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierBorderInfo", { fg = info_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo", { fg = info_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo", { fg = info_fg, bg = bg })
        -- Ok
        local ok_fg = get_attr("DiagnosticOk", "fg")
        vim.api.nvim_set_hl(0, "SnacksNotifierOk", { fg = fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierBorderOk", { fg = ok_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierIconOk", { fg = ok_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierTitleOk", { fg = ok_fg, bg = bg })
        -- Hint
        local hint_fg = get_attr("DiagnosticHint", "fg")
        vim.api.nvim_set_hl(0, "SnacksNotifierHint", { fg = fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierBorderHint", { fg = hint_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierIconHint", { fg = hint_fg, bg = bg })
        vim.api.nvim_set_hl(0, "SnacksNotifierTitleHint", { fg = hint_fg, bg = bg })
      end)
    end,
  },
}
