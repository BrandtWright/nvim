-------------------------------------------------------------------------------
--"Fuzzy find over recent files
-------------------------------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fo",
        require("telescope.builtin").oldfiles,
        mode = "n",
        desc = "Recent Files",
      },
    },
  },
}
