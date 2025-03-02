return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              -- Ensure that Ansible vault tags don't cause linting errors in
              -- yaml files. This is a bit annoying in Ansible variable
              -- definition files that do not contain any valid Ansible syntax
              -- (and therefore ft=yaml and ft!=yaml.ansible).and do not cause
              -- ansiblels to attatch to the yaml buffer.
              customTags = { "!vault scalar" },
            },
          },
        },
      },
    },
  },
}
