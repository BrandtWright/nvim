return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.cmd("hi! link @label.vimdoc Function")
      vim.cmd("hi! link @markup.heading.1.vimdoc Special")
      vim.cmd("hi! link @markup.heading.4.vimdoc HyperLink")
      vim.cmd("hi! link @markup.link.vimdoc Property")
      vim.cmd("hi! link @variable.parameter.vimdoc Property")
      vim.cmd("hi! link @keyword.exception.vim Exception")
      vim.cmd("hi! link @string.special.url.vimdoc Repeat")
      vim.cmd("hi! link @markup.link.vimdoc Repeat")
      vim.cmd("hi! link @string.special.vimdoc Structure")
    end,
  },
}
