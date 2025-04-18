return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.cmd("hi! link @parameter.c_sharp Italicized")
      vim.cmd("hi! link @type.qualifier.c_sharp Propterty")
      vim.cmd("hi! link @exception.c_sharp Exception")
      vim.cmd("hi! link @variable.member.c_sharp Identifier")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.cmd("hi! link @lsp.type.class.cs Type")
      vim.cmd("hi! link @lsp.type.struct.cs Structure")
      vim.cmd("hi! link @lsp.type.property.cs Identifier")
      vim.cmd("hi! link @lsp.type.delegateName.cs Method")
      vim.cmd("hi! link @lsp.type.extensionMethodName.cs Type")
      vim.cmd("hi! link @lsp.type.interface.cs Special")
      vim.cmd("hi! link @lsp.type.parameter.cs Italicized")
      vim.cmd("hi! link @lsp.type.typeParameter.cs Exception")
      vim.cmd("hi! link @lsp.mod.static.cs Bold")
      vim.cmd("hi! link @lsp.typemod.constantName.static.cs BrightBlueBold")
      vim.cmd("hi! link @lsp.type.keyword.cs Keyword")
    end,
  },
}
