-------------------------------------------------------------------------------
-- File Fuzzy Finders
-------------------------------------------------------------------------------
return {
  ------------------------------------------------------------------------------
  -- Silly Keys
  ------------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ff", false },
      { "<leader>fF", false },
      { "<leader>fc", false },
    },
  },
  {
    "LazyVim/LazyVim",
    keys = {
      { "<leader>ff", false },
      { "<leader>fF", false },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      -- moved to <leader>sgc
      { "<leader>fc", false },
    },
  },
  ------------------------------------------------------------------------------
  -- File Pickers
  ------------------------------------------------------------------------------
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Files (CWD)",
      },
      {
        "<leader>f.",
        function()
          Snacks.picker.files({
            finder = function()
              local dotfiles = vim.fn.systemlist("dotfiles")
              local items = {}
              for _, v in ipairs(dotfiles) do
                table.insert(items, {
                  file = v,
                  text = v,
                })
              end
              return items
            end,
          })
        end,
        desc = "Dotfiles",
      },
      {
        "<leader>fh",
        function()
          Snacks.picker.files({ dirs = { vim.fn.expand("~") } })
        end,
        desc = "Files (Home Directory)",
      },
      {
        "<leader>fl",
        function()
          local dir = vim.fn.input("Directory", "", "dir")
          if dir and dir ~= "" then
            Snacks.picker.files({
              dirs = { dir },
            })
          end
        end,
        desc = "Files (Location Picker)",
      },
      {
        "<leader>sgc",
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Neovim Config File",
      },
      {
        "<leader>sgp",
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath("data") })
        end,
        desc = "Neovim Plugin File",
      },
      {
        "<leader>fo",
        function()
          Snacks.picker.recent()
        end,
        mode = "n",
        desc = "Recent Files",
      },
      {
        "<leader>fs",
        function()
          Snacks.picker.files({
            dirs = { vim.fn.expand("~/.local/bin") },
          })
        end,
        desc = "Scripts",
      },
    },
  },
}
