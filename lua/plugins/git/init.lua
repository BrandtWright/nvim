local git = require("plugins.git.api")
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "git_config", "gitcommit", "git_rebase", "gitignore", "gitattributes" } },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ga", git.stash, mode = "n", desc = "Stash" },
      { "<leader>gbc", git.buffer_commits, mode = "n", desc = "Buffer Commits" },
      { "<leader>gc", git.commits, mode = "n", desc = "Commits" },
      { "<leader>gf", git.files, mode = "n", desc = "Files" },
      { "<leader>gF", git.files_with_preview, mode = "n", desc = "Files (With Preview)" },
      { "<leader>gS", git.status, mode = "n", desc = "Git Status (Tele)" },
      { "<leader>gy", git.branches, mode = "n", desc = "Branches" },
      { "<leader>gbc", git.buffer_commits_range, mode = "v", desc = "Buffer Commits (Range)" },
    },
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
    config = function()
      vim.opt.diffopt:append("hiddenoff")
      -- TODO: Add highlights
    end,
    cmd = { "Git" },
    keys = {
      { "<leader>gl", git.log, desc = "Git Log" },
      { "<leader>gr", git.resolve_conflicts, desc = "Resolve Merge Conflicts" },
      { "<leader>gdh", git.diff_get_2, desc = "Diffget //2" },
      { "<leader>gdl", git.diff_get_3, desc = "Diffget //3" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    cmd = { "Gitsigns" },
    opts = function(_, opts)
      -- Highlights
      local c = require("bw.config.colors")
      local highlights = require("bw.config.highlights")

      highlights.register({
        -- Git (Treesitter)
        { name = "GitSignsAdd", fg = c.green, bg = c.terminal, styles = {} },
        { name = "GitSignsChange", fg = c.yellow, bg = c.terminal, styles = {} },
        { name = "GitSignsDelete", fg = c.red, bg = c.terminal, styles = {} },
      })

      local my_opts = {
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "│" },
          untracked = { text = "│" },
        },
        on_attach = function(buffer)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          -- stylua: ignore start

          -- Navigation
          map("n", "]h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gs.nav_hunk("next")
            end
          end, "Next Hunk")
          map("n", "[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gs.nav_hunk("prev")
            end
          end, "Prev Hunk")
          map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
          map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")

          -- Stage, Reset, Undoo
          map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")

          -- Preview
          map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
          map("n", "<leader>ghP", gs.preview_hunk, "Preview Hunk")

          -- Blame
          map("n", "<leader>gml", function() gs.blame_line() end, "Blame Line")
          map("n", "<leader>gmL", function() gs.blame_line({ full = true }) end, "Blame Line Full")
          map("n", "<leader>gmb", function() gs.blame() end, "Blame Buffer")

          -- Diff
          map("n", "<leader>gdd", gs.diffthis, "Diff This")
          map("n", "<leader>gdD", function() gs.diffthis("~") end, "Diff This ~")

          -- Lists
          map("n", "<leader>ghq", ":Gitsigns setqflist<CR>", "Send to QuickFix List")
          map("n", "<leader>ghl", ":Gitsigns setloclist<CR>", "Send to Location List")

          -- Buffer
          map("n", "<leader>gbs", ":Gitsigns stage_buffer<CR>", "Stage Buffer")
          map("n", "<leader>gbr", ":Gitsigns reset_buffer<CR>", "Reset Buffer")

          -- Toggles
          map("n", "<leader>gts", ":Gitsigns toggle_signs<CR>", "Toggle Signs")
          map("n", "<leader>gtm", ":Gitsigns toggle_current_line_blame<CR>", "Toggle Current Line Blame")
          map("n", "<leader>gtd", ":Gitsigns toggle_deleted<CR>", "Toggle Deleted")
          map("n", "<leader>gtw", ":Gitsigns toggle_word_diff<CR>", "Toggle Word Diff")
          map("n", "<leader>gtl", ":Gitsigns toggle_linehl<CR>", "Toggle Line Highlight")
          map("n", "<leader>gtn", ":Gitsigns toggle_numhl<CR>", "Toggle Number Highlight")
        end,
      }
      return vim.tbl_deep_extend("force", opts or {}, my_opts)
    end,
  },
}
