local o = vim.opt_local

-- Do not automatically insert the current comment
-- leader after hitting 'o' or 'O' in normal mode.
o.formatoptions:remove("o")
o.textwidth = 120
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.smartindent = true
