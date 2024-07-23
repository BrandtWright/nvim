local o = vim.opt_local

o.formatoptions:remove("o")
o.textwidth = 120
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2

-- Custom Surrounds
vim.keymap.set("v", "<LocalLeader>scl", [[cprint(vim.inspect(<c-r>"))<esc>]], { noremap = false })
