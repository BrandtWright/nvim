return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- Ensure ansible is installed
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "ansible-lint")

      -- Set up a buf-local keymap for ansible-list
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("AnsibleKeyMaps", { clear = true }),
        pattern = "yaml.ansible",
        callback = function()
          local keymap_opts = { buffer = true, noremap = true, silent = true, desc = "Ansible Lint Buffer" }
          vim.keymap.set("n", "<localleader>a", function()
            local filepath = vim.fn.expand("%")
            local cmd = "ansible-lint " .. filepath .. " && anykey"
            Snacks.terminal.open(cmd, {
              win = {
                border = "single",
                style = "terminal",
                relative = "editor",
                width = 120,
                height = 25,
              },
              interactive = true,
            })
          end, keymap_opts)
        end,
      })
    end,
  },
}
