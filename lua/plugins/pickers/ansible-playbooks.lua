return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>oa",
        function()
          local dir = vim.fn.expand("~/repos/bitpit-host-bootstrapper/")
          if vim.fn.isdirectory(dir) == 0 then
            require("bw.util.notification").warn("Bootstrapper repo not found: " .. dir, "Ansible Playbooks")
            return
          end
          Snacks.picker.files({
            dirs = { dir },
            hidden = true,
          })
        end,
        desc = "Ansible Playbooks",
      },
    },
  },
}
