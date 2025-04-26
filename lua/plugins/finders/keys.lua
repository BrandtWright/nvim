local tele = require("plugins.finders.helpers")

return {

  ------------------------------------------------------------------------------
  -- Files
  ------------------------------------------------------------------------------

  {
    "<leader>fa",
    function()
      tele.find_files({ cwd = vim.fn.expand("~/repos/bitpit-host-bootstrapper") })
    end,
    mode = "n",
    desc = "Bitpit Playbooks",
  },
  {
    "<leader>fA",
    function()
      tele.find_files({ cwd = vim.fn.expand("~/repos/bitpit-host-bootstrapper"), hidden = true })
    end,
    mode = "n",
    desc = "Bitpit Playbooks (All Files)",
  },

  -----------------------------------------------------------------------------
  -- <leader>s
  -----------------------------------------------------------------------------
  -- Emoji
  {
    "<leader>se",
    function()
      tele.emoji()
    end,
    mode = "n",
    desc = "Emoji",
  },
  -- Spell Suggest
  {
    "z=",
    function()
      tele.spell_suggest()
    end,
    mode = "n",
    desc = "Spelling Suggestions",
  },
}
