return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>oa",
        function()
          Snacks.picker.files({
            dirs = { vim.fn.expand("~/repos/bitpit-host-bootstrapper/") },
            hidden = true,
          })
        end,
        desc = "Ansible Playbooks",
      },
    },
  },
}
