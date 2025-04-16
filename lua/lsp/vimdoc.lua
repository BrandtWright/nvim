return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "@label.vimdoc", fg = c.yellow },
        { name = "@markup.heading.1.vimdoc", fg = c.gold, bg = c.terminal, styles = {} },
        { name = "@markup.heading.4.vimdoc", fg = c.bright_blue, bg = c.terminal, styles = {} },
        { name = "@markup.link.vimdoc", fg = c.green, bg = c.terminal, styles = {} },
        { name = "@variable.parameter.vimdoc", fg = c.green, bg = c.terminal, styles = {} },
        { name = "@keyword.exception.vim", fg = c.red, bg = c.terminal, styles = {} },
        { name = "@string.special.url.vimdoc", fg = c.bright_magenta, bg = c.terminal, styles = {} },
        { name = "@markup.link.vimdoc", fg = c.bright_magenta, bg = c.terminal, styles = {} },
      })
    end,
  },
}
