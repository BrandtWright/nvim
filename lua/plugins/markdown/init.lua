return {
  {
    "lukas-reineke/headlines.nvim",
    opts = function(_, opts)
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")
      highlights.register({
        { name = "Headline1", fg = c.terminal, bg = c.dark_red, styles = { "b" } },
        { name = "Headline2", fg = c.terminal, bg = c.dark_orange, styles = { "b" } },
        { name = "Headline3", fg = c.terminal, bg = c.gold, styles = { "b" } },
      })

      opts = opts or {}

      -- Markdown
      opts.markdown = opts.markdown or {}
      opts.markdown.fat_headlines = false
    end,
  },
}
