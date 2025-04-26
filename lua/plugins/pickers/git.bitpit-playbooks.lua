return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>oa",
        function()
          require("telescope.builtin").git_files({
            cwd = vim.fn.expand("~/repos/bitpit-host-bootstrapper/"),
          })
        end,
        desc = "Bitbit Playbooks",
      },
    },
  },
}
