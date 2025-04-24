local tele = require("plugins.finders.helpers")

return {

  ------------------------------------------------------------------------------
  -- Disabled Keys
  ------------------------------------------------------------------------------
  { "<leader>sa", false }, -- Auto commands are in snacks
  { "<leader>ss", false }, -- Lsp_ducument_symbols are in snacks
  { "<leader>sS", false }, -- Lsp_workspace_symbols are in snacks
  { "<leader>sd", false }, -- Document diagnostics are in snacks
  { "<leader>sD", false }, -- Workspace diagnostics are in snacks
  { "<leader>sC", false }, -- Commands are in <leader>s:
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
    "<leader>fh",
    function()
      tele.find_files({ cwd = vim.fn.expand("~") })
    end,
    mode = "n",
    desc = "In Home Directory",
  },
  {
    "<leader>fH",
    function()
      tele.find_files({ cwd = vim.fn.expand("~"), hidden = true })
    end,
    mode = "n",
    desc = "Home Directory (All Files)",
  },
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
  {
    "<leader>ft",
    function()
      tele.current_buffer_tags()
    end,
    mode = "n",
    desc = "Buffer Tags",
  },
  {
    "<leader>sb",
    "<cmd>Telescope current_buffer_fuzzy_find<cr>",
    mode = "n",
    desc = "Fuzzy Find in Buffer",
  },
  -- Dotfiles
  {
    "<leader>f.",
    function()
      tele.find_dotfiles()
    end,
    mode = "n",
    desc = "Dotfiles",
  },
  {
    "<leader>fs",
    function()
      tele.local_bin()
    end,
    mode = "n",
    desc = "Scripts",
  },
  -- Diagnostics
  {
    "<leader>fd",
    function()
      tele.document_diagnostics()
    end,
    mode = "n",
    desc = "Document Diagnostics",
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
