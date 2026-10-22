return {
  {
    -- The LazyVim haskell extra formats with fourmolu (conform) and lints with
    -- hlint (nvim-lint) but leaves both to be installed externally. Mason ships
    -- standalone binaries for both, so install them here. (cabal-fmt, the
    -- extra's cabal formatter, isn't in Mason; it's listed in :checkhealth bw.)
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "fourmolu", "hlint" })
    end,
  },
}
