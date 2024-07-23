return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Highlights
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "LspInfoBorder", fg = c.brown, bg = c.terminal, styles = {} },
      })

      -- Ensure that the LspInfo popup has a border
      require("lspconfig.ui.windows").default_options.border = "single"
    end,
  },
}
