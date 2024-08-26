local c = require("bw.config.colors")
local highlights = require("bw.config.highlights")
highlights.register({
  { name = "NeoTreeDirectoryIcon", fg = c.blue, bg = nil, styles = {} },
  { name = "NeoTreeDirectoryName", fg = c.white, bg = nil, styles = {} },
})

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
    opts = {
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
      },
    },
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
          vim.cmd("Vifm")
        end,
        desc = "Vifm",
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
