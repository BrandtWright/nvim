return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              customTags = {
                -- Ensure that Ansible vault tags don't cause linting errors in
                -- yaml files. This is a bit annoying in Ansible variable
                -- definition files that do not contain any valid Ansible syntax.
                -- In this case, ft=yaml and ft!=yaml.ansible so, will not cause
                -- ansiblels to attatch to the yaml buffer. Adding the !vault
                -- scalar to customTags prevents yamlls from complaining about
                -- variable definitions that use ansible-vault to store
                -- encrypted strings.
                "!vault scalar",
              },
            },
          },
        },
      },
    },
  },
}
