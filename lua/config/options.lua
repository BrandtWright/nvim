-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "

-- Color and Brightness Options
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Disable the trouble symbols in lualine (method/function names and symbols)
vim.g.trouble_lualine = false

local opt = vim.opt

-- TODO: set opt.statuscolumn to something better so that gitsigns are not hanging out in nomans land

-- opt.numberwidth = 3
-- opt.statuscolumn = "%@SignCb@%s%=%T%@NumCb@%r│%T"
-- opt.statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s"

opt.laststatus = 3

-- Ignore compiled files
opt.wildignore = "__pycache__"
opt.wildignore = opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }

opt.wildmode = { "longest", "list", "full" }

-- Cool floating window popup menu for completion on command line
opt.pumblend = 0

opt.wildmode = opt.wildmode - "list"
opt.wildmode = opt.wildmode + { "longest", "full" }

opt.wildoptions = "pum"
opt.pumheight = 10

opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1 -- Height of the command bar
opt.incsearch = true -- Makes search act like search in modern browsers
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.relativenumber = true -- Show line numbers
opt.number = true -- But show the actual number for the line we're on
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query
opt.hidden = true -- I like having buffers stay around
opt.cursorline = true -- Highlight the current line
opt.equalalways = false -- I don't like my windows changing all the time
opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom
opt.updatetime = 1000 -- Make updates happen faster
opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor

-- Tabs
opt.autoindent = true
opt.smartindent = true
opt.cindent = false
opt.wrap = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.breakindent = true
opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "1"
vim.opt.fillchars = {
  fold = " ", -- remove trailing filler dots
  foldopen = "", -- ▼
  foldclose = "", -- ▶
  foldsep = " ",
  eob = " ",
}

function _G.TreesitterFoldText()
  local start_line = vim.fn.getline(vim.v.foldstart)
  local count = vim.v.foldend - vim.v.foldstart + 1
  local suffix = string.format("  … [%d lines]", count)
  local prefix = "  "
  local max_width = vim.api.nvim_win_get_width(0) - 2 -- allow for fold column
  local line = vim.trim(start_line)
  local content_width = max_width - vim.fn.strdisplaywidth(prefix .. suffix)

  -- truncate if needed
  if vim.fn.strdisplaywidth(line) > content_width then
    line = vim.fn.strcharpart(line, 0, content_width - 1) .. "…"
  end

  -- left-justified + padded manually
  local foldtext = prefix .. line .. suffix
  local total_padding = max_width - vim.fn.strdisplaywidth(foldtext)
  if total_padding > 0 then
    foldtext = foldtext .. string.rep(" ", total_padding)
  end

  return foldtext
end

vim.opt.foldtext = "v:lua.TreesitterFoldText()"

opt.belloff = "all" -- Just turn the dang bell off

opt.clipboard = "unnamedplus"

opt.inccommand = "split"
opt.swapfile = false -- Living on the edge
opt.shada = { "!", "'1000", "<50", "s10", "h" }

opt.mouse = "n"

-- Spelling
vim.opt.spelllang = { "en_us" }
vim.opt.spell = false

-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.
--
-- TODO: w, {v, b, l}
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

-- set joinspaces
opt.joinspaces = false -- Two spaces and grade school, we're done

-- set fillchars=eob:~
opt.fillchars = { eob = "~" }

opt.guicursor = table.concat({
  "n-v-c-sm:block-Cursor", -- normal, visual, command, select: block with Cursor highlight
  "i-ci-ve:ver25-Cursor", -- insert, insert command, visual exclusive: vertical bar
  "r-cr-o:hor20-Cursor", -- replace, confirm, operator-pending: horizontal bar
}, ",")
