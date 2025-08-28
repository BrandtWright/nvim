local git = require("plugins.git.api")
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- silly keys
      { "<leader>gs", false },
      { "<leader>gc", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>gs", git.status, desc = "Status" },
      { "<leader>ga", git.stash, desc = "Stash" },
      { "<leader>gca", git.commits, desc = "All" },
      { "<leader>gcf", git.buffer_commits, desc = "Current File" },
      { "<leader>gcl", git.line_commits, desc = "Line" },
      { "<leader>gf", git.files, desc = "Files" },
      { "<leader>gy", git.branches, desc = "Branches" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- Highlights
    opts = function(_, opts)
      local apply_highlights = function()
        vim.cmd("hi! link @markup.heading.gitcommit Special")
      end
      apply_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("TreesitterGitHighlights", { clear = true }),
        pattern = "*",
        callback = apply_highlights,
        desc = "Reapply nvim-treesitter git highlight groups after colorscheme changes",
      })

      local my_opts = {
        ensure_installed = {
          "git_config",
          "gitcommit",
          "git_rebase",
          "gitignore",
          "gitattributes",
        },
      }
      return vim.tbl_deep_extend("force", opts or {}, my_opts)
    end,
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
    config = function()
      vim.opt.diffopt:append("hiddenoff")

      -- Set keymaps for fugitive files
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("FugitiveBufLocalKeymaps", { clear = true }),
        pattern = "fugitive", -- specify your filetype
        callback = function()
          -- easy close key
          vim.keymap.set("n", "q", "<cmd>close<cr>", { desc = "Close", buffer = true })
        end,
      })
    end,
    cmd = { "Git" },
    keys = {
      { "<leader>gl", git.log, desc = "Git Log" },
      { "<leader>gv", "<cmd>vertical Git<cr>", mode = "n", desc = "Branches" },
      { "<leader>gdh", git.diff_get_2, desc = "Diffget //2" },
      { "<leader>gdl", git.diff_get_3, desc = "Diffget //3" },
      {
        "<leader>gS",
        function()
          -- Use the current buffer path as cwd in case we are in a buffer outside of cwd
          -- This allows us to gracefully handle failure and issue the appropriate warnings
          -- when we have wandered outside a repo
          git.fugitive({ cwd = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h") })
        end,
        desc = "Status",
      },
      { "<leader>gp", "<cmd>Git pull<cr>", mode = "n", desc = "Pull", ft = "fugitive" },
      { "<leader>gP", "<cmd>Git push<cr>", mode = "n", desc = "Push", ft = "fugitive" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    cmd = { "Gitsigns" },
    opts = function(_, opts)
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
