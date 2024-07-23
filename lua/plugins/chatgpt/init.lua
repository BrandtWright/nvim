-- Highlights
local c = require("bw.config.colors")
local highlights = require("bw.config.highlights")
highlights.register({
  { name = "ChatGPTTotalTokens", fg = nil, bg = c.brown, styles = {} },
  { name = "ChatGPTTotalTokensBorder", fg = c.brown, bg = nil, styles = {} },
})

return {
  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    keys = require("plugins.chatgpt.keys"),
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTEditWithInstructions",
      "ChatGPTRun",
    },
    opts = require("plugins.chatgpt.opts"),
  },
}
