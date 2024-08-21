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
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        disable = function(_, buf)
          if require("bw.util.fs").buff_exceeds_size(buf, 1024 * 1024 * 5) then
            vim.notify("Treesitter disabled due to file size")
            return true
          end
        end,
      },
    },
  },
}
