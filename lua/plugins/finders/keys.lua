local tele = require("plugins.finders.helpers")

return {

  ------------------------------------------------------------------------------
  -- Silly Keys
  ------------------------------------------------------------------------------
  { "<leader>ss", false }, -- Lsp_ducument_symbols are in snacks
  { "<leader>sS", false }, -- Lsp_workspace_symbols are in snacks
  { "<leader>sR", false }, -- Resume is <leader>sr
  { "<leader>sk", false }, -- keymaps are in snacks
  { '<leader>s"', false }, -- Registers are in snacks

  ------------------------------------------------------------------------------
  -- Notification Keys
  ------------------------------------------------------------------------------
  { "<leader>snn", tele.notifications, mode = "n", desc = "Notifications" },

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
  {
    "<leader>fo",
    function()
      tele.oldfiles()
    end,
    mode = "n",
    desc = "Recent Files",
  },
  -----------------------------------------------------------------------------
  -- <leader>s
  -----------------------------------------------------------------------------
  {
    "<leader>sc",
    function()
      tele.command_history()
    end,
    mode = "n",
    desc = "Command History",
  },
  {
    "<leader>sh",
    false,
  },
  {
    "<leader>sH",
    false, -- Turn off highlight picker
  },
  {
    "<leader>sM",
    function()
      tele.man_pages()
    end,
    mode = "n",
    desc = "Man Pages",
  },
  {
    "<leader>sm",
    function()
      tele.marks()
    end,
    mode = "n",
    desc = "Marks",
  },
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
