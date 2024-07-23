return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        disable = function(_, buf)
          if require("bw.util.fs").buff_exceeds_size(buf, 1024 * 1024 * 5) then
            vim.notify("Treesitter disabled due to file size")
            return true
          end
        end,
      },
    },
  },
}
