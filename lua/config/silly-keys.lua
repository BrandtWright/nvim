local M = {}

M.disable = function()
  local del = vim.keymap.del

  -- Window Navigation
  del("n", "<C-h>")
  del("n", "<C-j>")
  del("n", "<C-k>")
  del("n", "<C-l>")

  -- Buffers
  del("n", "<leader>`")
  del("n", "<leader>bb")

  -- Search
  del("n", "n")
  del("x", "n")
  del("o", "n")
  del("n", "N")
  del("x", "N")
  del("o", "N")

  -- Floating Terminal
  del("n", "<c-_>")
  del("n", "<leader>fT")
  del("n", "<c-/>")
  del("t", "<c-_>")

  -- tabs (Remove)
  del("n", "<leader><tab>l")
  del("n", "<leader><tab>f")
  del("n", "<leader><tab><tab>")
  del("n", "<leader><tab>]")
  del("n", "<leader><tab>d")
  del("n", "<leader><tab>[")
  del("n", "<leader><tab>o")

  del("n", "<leader>ud")
  del("n", "<leader>ub") -- Toggle light/dark mode
  del("n", "<leader>uc") -- Toggle conceal
  -- del("n", "<leader>uC") -- Colorscheme with Preview

  -- Lazy
  del("n", "<leader>l") -- Lazy.nvim Status
  del("n", "<leader>L") -- LazyVim Log
end

return M
