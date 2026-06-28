return {
  {
    -- The <localleader>a lint keymap lives in after/ftplugin/ansible.lua so it
    -- attaches reliably to the first ansible buffer (registering it here, in a
    -- lazy plugin's opts, races the FileType event that loads the plugin).
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "ansible-lint")
    end,
  },
}
