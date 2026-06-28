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

        -- Each level borrows its accent from the matching Diagnostic group: the
        -- body uses Normal fg/bg; the border/icon/title use the diagnostic fg.
        for _, level in ipairs({ "Error", "Warn", "Info", "Ok", "Hint" }) do
          local accent = get_attr("Diagnostic" .. level, "fg")
          vim.api.nvim_set_hl(0, "SnacksNotifier" .. level, { fg = fg, bg = bg })
          for _, part in ipairs({ "Border", "Icon", "Title" }) do
            vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. level, { fg = accent, bg = bg })
          end
        end
      end)
    end,
  },
}
