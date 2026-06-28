local highlights = require("bw.util.highlights")

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
    -- Defined here (not in config/keymaps.lua) so they lazy-load neo-tree on
    -- demand. The old `if pcall(require, "neo-tree")` guard in keymaps.lua ran at
    -- VeryLazy, before neo-tree had loaded, so it was false and the maps silently
    -- never registered.
    keys = {
      { "<leader>es", "<cmd>Neotree left<cr>", desc = "Neotree (Left)" },
      { "<leader>ef", "<cmd>Neotree float<cr>", desc = "Neotree (Float)" },
    },
    opts = function(_, opts)
      highlights.on_colorscheme("NeoTreeHighlights", function()
        local get = highlights.get_attribute
        local hl = vim.api.nvim_set_hl

        local secondary_accent_fg = get("WinBarNC", "fg") or "#4d4136"
        local secondary_accent_bg = get("WinBarNC", "bg") or "#4d4136"
        local normal_fg = get("Normal", "fg") or "#ffffff"

        hl(0, "NeoTreeTitleBar", { fg = secondary_accent_fg, bg = secondary_accent_bg })
        hl(0, "NeoTreeFloatBorder", { fg = secondary_accent_bg, bg = secondary_accent_bg })
        hl(0, "NeoTreeDirectoryName", { fg = normal_fg, bg = "" })
        vim.cmd("hi! link NeoTreeDirectoryIcon Directory")
        vim.cmd("hi! link NeoTreeCursorLine PmenuSel")
        vim.cmd("hi! link NeoTreeFileStats Comment")
      end)

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
      -- `-` is intentionally left to vim-vinegar (open netrw on the parent dir
      -- with the current file selected). Mapping it here would shadow vinegar
      -- and needlessly load fm-nvim just to call netrw's :Explore.
      {
        "_",
        function()
          vim.cmd("Vifm")
        end,
        desc = "Vifm",
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    -- harpoon2 (pinned via the lazyvim harpoon2 extra) takes its config under
    -- `settings`; the v1 `global_settings` key was silently ignored.
    opts = {
      settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
      },
    },

    -- stylua: ignore
    keys = {
      { "<leader>1", false },
      { "<leader>2", false },
      { "<leader>3", false },
      { "<leader>4", false },
      { "<leader>5", false },
      { "<leader>H", false },
      { "<leader>h", false },
      { "<leader>hh", function() require("harpoon"):list():add() end, desc = "Add", },
      { "<leader>ha", function() require("harpoon"):list():select(1) end, desc = "Preset One", },
      { "<leader>hs", function() require("harpoon"):list():select(2) end, desc = "Preset Two", },
      { "<leader>hd", function() require("harpoon"):list():select(3) end, desc = "Preset Three", },
      { "<leader>hf", function() require("harpoon"):list():select(4) end, desc = "Preset Four", },
      { "<leader>hg", function() require("harpoon"):list():select(5) end, desc = "Preset Five", },
      {
        "<leader>hm",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Menu",
      },
    },
  },
}
