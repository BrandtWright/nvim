local tele = require("plugins.finders.helpers")

return {

  ------------------------------------------------------------------------------
  -- Silly Keys
  ------------------------------------------------------------------------------
  { "<leader>sR", false }, -- Resume is <leader>sr

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
  {
    "<leader>so",
    function()
      tele.vim_options()
    end,
    mode = "n",
    desc = "Options",
  },
  {
    "<leader>sr",
    function()
      tele.resume()
    end,
    mode = "n",
    desc = "Resume Telescope",
  },
  -- Jumps
  {
    "<leader>sj",
    function()
      tele.jumplist()
    end,
    mode = "n",
    desc = "Jumps",
  },
  -- QuickFix List
  {
    "<leader>sq",
    function()
      tele.quickfix()
    end,
    mode = "n",
    desc = "QuickFix List",
  },
  -- Location List
  {
    "<leader>sl",
    function()
      tele.loclist()
    end,
    mode = "n",
    desc = "Location List",
  },
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
