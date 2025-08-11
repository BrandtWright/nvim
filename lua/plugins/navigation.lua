return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    config = function()
      vim.cmd([[let g:tmux_navigator_disable_when_zoomed = 1]])
    end,
  },
  { "tpope/vim-vinegar" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      local apply_highlights = function()
        vim.cmd("hi! link NeoTreeDirectoryIcon Directory")
        vim.cmd("hi! link NeoTreeDirectoryName White")
        vim.cmd("hi! link NeoTreeTitleBar dark_panel")
        vim.cmd("hi! link NeoTreeFloatBorder dark_panel_normal_background")
        vim.cmd("hi! link NeoTreeCursorLine PmenuSel")
        vim.cmd("hi! link NeoTreeFileStats Comment")
      end

      apply_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("NeoTreeHighlights", { clear = true }),
        pattern = "*",
        callback = apply_highlights,
        desc = "Reapply NeoTree highlight groups after colorscheme changes",
      })

      local my_opts = {
        window = {
          mappings = {
            ["<space>"] = {
              "toggle_node",
              nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["l"] = "open",
            ["h"] = "close_node",
          },
        },
        filesystem = {
          bind_to_cwd = true,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
          hijack_netrw_behavior = "disabled",
        },
      }
      return vim.tbl_deep_extend("force", opts or {}, my_opts)
    end,
  },
  {
    "is0n/fm-nvim",
    cmd = { "Ranger", "Vifm" },
    opts = {
      ui = {
        float = {
          border = "single",
        },
      },
    },
    keys = {
      {
        "-",
        function()
          vim.cmd("Explore")
        end,
        desc = "Netrw",
      },
      {
        "_",
        function()
          vim.cmd("Vifm")
        end,
        desc = "Vifm",
      },
      {
        "q",
        function()
          vim.cmd(":q")
        end,
        desc = "Quit",
        mode = "n",
        ft = "Fm",
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    opts = {
      global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
      },
    },
    keys = {
      { "<leader>1", false },
      { "<leader>2", false },
      { "<leader>3", false },
      { "<leader>4", false },
      { "<leader>5", false },
      { "<leader>H", false },
      { "<leader>h", false },
      {
        "<leader>hm",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Menu",
      },
      {
        "<leader>hh",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Add",
      },
      {
        "<leader>ha",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Preset One",
      },
      {
        "<leader>hs",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Preset Two",
      },
      {
        "<leader>hd",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Preset Three",
      },
      {
        "<leader>hf",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Preset Four",
      },
      {
        "<leader>hg",
        function()
          require("harpoon"):list():select(5)
        end,
        desc = "Preset Five",
      },
    },
  },
}
