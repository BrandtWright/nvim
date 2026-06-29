-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "
-- Set the local leader explicitly rather than relying on LazyVim's default.
-- It must NOT be the same key as mapleader (Space): the slip buffer-local maps
-- (<localleader>s/v/a in lua/plugins/pickers/slips.lua) would otherwise expand
-- to <Space>s/v/a and shadow the global <leader>s* picker namespace inside slip
-- buffers. "\\" matches LazyVim's default, so this is explicit, not a change.
vim.g.maplocalleader = "\\"

-- Disable the trouble symbols in lualine (method/function names and symbols)
vim.g.trouble_lualine = false

-- Default SQL dialect for syntax/`commentstring`. This is a global by design
-- (read by $VIMRUNTIME/syntax/sql.vim when a SQL buffer loads, and the runtime
-- recommends setting it in config) -- so it lives here rather than in
-- after/ftplugin/sql.vim, where it was re-set as a global on every SQL buffer.
vim.g.sql_type_default = "mysql"

-- Keep Copilot (and any other AI) OUT of the blink completion menu. As a menu
-- source it would query Copilot on every popup -- and Copilot costs money.
-- Copilot is configured as opt-in, on-demand inline suggestions instead; see
-- lua/plugins/ai/init.lua.
vim.g.ai_cmp = false

local opt = vim.opt

-- Color and Brightness Options
opt.termguicolors = true
opt.background = "dark"

opt.laststatus = 3

-- Ignore compiled / generated files in completion and globbing.
-- `:append` adds to any existing value instead of replacing it.
opt.wildignore:append({ "*.o", "*~", "*.pyc", "*pycache*" })

opt.wildmode = { "longest", "list", "full" }

-- Cool floating window popup menu for completion on command line
opt.pumblend = 0

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
opt.updatetime = 200 -- Faster CursorHold / swap writes (matches LazyVim's default)
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

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = "1"
opt.fillchars = {
  fold = " ", -- remove trailing filler dots
  foldopen = "▼",
  foldclose = "▶",
  foldsep = " ",
  eob = "~",
}

--- Creates custom fold text using Treesitter with intelligent truncation.
--- Gathers the live window/buffer state and delegates the (pure, unit-tested)
--- formatting to bw.util.foldtext.
---@return string The formatted fold text with padding to fill the window width
function _G.TreesitterFoldText()
  return require("bw.util.foldtext").build({
    line = vim.fn.getline(vim.v.foldstart),
    count = vim.v.foldend - vim.v.foldstart + 1,
    width = vim.api.nvim_win_get_width(0),
  })
end

opt.foldtext = "v:lua.TreesitterFoldText()"

opt.belloff = "all" -- Just turn the dang bell off

opt.clipboard = "unnamedplus"

opt.inccommand = "split"
opt.swapfile = false -- Living on the edge
opt.shada = { "!", "'1000", "<50", "s10", "h" }

opt.mouse = "n"

-- Spelling
opt.spelllang = { "en_us" }
opt.spell = false

-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.
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
opt.joinspaces = false -- one space between sentences.

opt.guicursor = table.concat({
  "n-v-c-sm:block-Cursor", -- normal, visual, command, select: block with Cursor highlight
  "i-ci-ve:ver25-Cursor", -- insert, insert command, visual exclusive: vertical bar
  "r-cr-o:hor20-Cursor", -- replace, confirm, operator-pending: horizontal bar
}, ",")

-- Diagnostic display is configured in lua/plugins/diagnostics.lua via the
-- nvim-lspconfig `opts.diagnostics` table. Setting it here would be clobbered:
-- LazyVim applies its own vim.diagnostic.config() during LSP setup, which runs
-- after this file loads.
