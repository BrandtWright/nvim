local instrument_ansible_buffer = function()
  -- Set up buffer-local key map for `ansible-lint`
  vim.keymap.set("n", "<localleader>a", function()
    Snacks.terminal.open("ansible-lint " .. vim.fn.expand("%") .. " && anykey", {
      win = { border = "single", style = "terminal", relative = "editor", width = 120, height = 25 },
      interactive = true,
    })
  end, { buffer = true, noremap = true, silent = true, desc = "Ansible Lint Buffer" })
end

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- Ensure ansible is installed
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "ansible-lint")
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("AnsibleLintKeyMapAutoGroup", { clear = true }),
        pattern = "yaml.ansible",
        callback = instrument_ansible_buffer,
      })
    end,
  },
}
