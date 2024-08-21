local tele = require("user.finders.helpers")

return {

  ------------------------------------------------------------------------------
  -- Convenience Keys
  ------------------------------------------------------------------------------
  { "<leader>k", tele.find_files, mode = "n", desc = "Find Files" },
  { "<leader>/", tele.rg, mode = "n", desc = "Ripgrep" },

  ------------------------------------------------------------------------------
  -- Files
  ------------------------------------------------------------------------------

  { "<leader>ff", tele.find_files, mode = "n", desc = "Files" },
  {
    "<leader>fF",
    function()
      tele.find_files({ hidden = true })
    end,
    mode = "n",
    desc = "All Files",
  },
  {
    "<leader>fl",
    function()
      tele.find_files({
        cwd = vim.fn.input("Directory: "),
      })
    end,
    mode = "n",
    desc = "Files from Location",
  },
  {
    "<leader>fL",
    function()
      tele.find_files({
        cwd = vim.fn.input("Directory: "),
        hidden = true,
      })
    end,
    mode = "n",
    desc = "All Files from Location",
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
    "<leader>fu",
    "<cmd>Telescope current_buffer_fuzzy_find<cr>",
    mode = "n",
    desc = "Fuzzy Find in Buffer",
  },
  {
    "<leader>rp",
    function()
      tele.grep_string({ shorten_path = true, search = vim.fn.input("Grep String: ") })
    end,
    mode = "n",
    desc = "Grep from Location",
  },
  {
    "<leader>rt",
    function()
      tele.grep_file_type()
    end,
    mode = "n",
    desc = "Grep File Type",
  },
  {
    "<leader>rs",
    function()
      tele.grep_string()
    end,
    mode = "n",
    desc = "Grep String",
  },
  {
    "<leader>rr",
    function()
      tele.rg()
    end,
    mode = "n",
    desc = "Ripgrep",
  },
  {
    "<leader>rR",
    function()
      tele.rg_location_prompt()
    end,
    mode = "n",
    desc = "Rg from Location",
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
  -- LSP Symbols
  {
    "<leader>fy",
    function()
      tele.lsp_document_symbols()
    end,
    mode = "n",
    desc = "Document Symbols",
  },
  {
    "<leader>fY",
    function()
      tele.lsp_workspace_symbols()
    end,
    mode = "n",
    desc = "Workspace Symbols",
  },
  -----------------------------------------------------------------------------
  -- <leader>s
  -----------------------------------------------------------------------------
  {
    '<leader>s"',
    function()
      tele.registers()
    end,
    mode = "n",
    desc = "Registers",
  },
  {
    "<leader>sa",
    function()
      tele.autocommands()
    end,
    mode = "n",
    desc = "Auto Commands",
  },
  {
    "<leader>sc",
    function()
      tele.command_history()
    end,
    mode = "n",
    desc = "Command History",
  },
  {
    "<leader>s:",
    function()
      tele.commands()
    end,
    mode = "n",
    desc = "Commands",
  },
  {
    "<leader>sh",
    function()
      tele.help_tags()
    end,
    mode = "n",
    desc = "Help Pages",
  },
  {
    "<leader>sH",
    function()
      tele.highlights()
    end,
    mode = "n",
    desc = "Hilight Groups",
  },
  {
    "<leader>sk",
    function()
      tele.keymaps()
    end,
    mode = "n",
    desc = "Key Maps",
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
