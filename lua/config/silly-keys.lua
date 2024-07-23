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

  -- Lazygit
  del("n", "<leader>gg")
  del("n", "<leader>gG")
  -- del("n", "<leader>gb")
  -- del("n", "<leader>gB")
  -- del("n", "<leader>gf")
  -- del("n", "<leader>gl")
  del("n", "<leader>gL")

  -- Floating Terminal
  del("n", "<c-_>")
  del("n", "<leader>fT")
  del("n", "<c-/>")
  del("t", "<c-_>")
  del("t", "<C-h>")
  del("t", "<C-j>")
  del("t", "<C-k>")
  del("t", "<C-l>")

  -- Windows
  -- del("n", "<leader>wd")
  -- del("n", "<leader>ww")
  -- del("n", "<leader>w-")
  -- del("n", "<leader>w|")
  del("n", "<leader>-")
  del("n", "<leader>|")

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
end

return M
