return {
  {
    -- ansible-lint is the linter the ansible language server (from the LazyVim
    -- ansible extra) runs for inline diagnostics; ensure it's installed.
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "ansible-lint")
    end,
  },
}
