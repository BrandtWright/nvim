-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Disable the silly stuff
local sillyKeys = require("config.silly-keys")
for _, key in ipairs(sillyKeys) do
  for _, mode in ipairs(key.modes) do
    vim.keymap.del(mode, key.lhs)
  end
end

--------------------------------------------------------------------------------
-- Function Keys
--------------------------------------------------------------------------------
map("n", "<F7>", function()
  vim.cmd("setlocal spell!")
end, { desc = "Project", silent = true })

--------------------------------------------------------------------------------
-- Movement
--------------------------------------------------------------------------------
-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "<C-n>", "j<C-e>", { desc = "Scroll Up" })
map("n", "<C-p>", "k<C-y>", { desc = "Scroll Down" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

--------------------------------------------------------------------------------
-- Windows
--------------------------------------------------------------------------------
map("n", "<leader>ws", "<cmd>split<cr>", { desc = "Vertical Split", silent = true })
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical Split", silent = true })
map("n", "<leader>wd", "<c-w>c", { desc = "Delete Window", silent = true })
map("n", "<leader>wo", "<c-w>o", { desc = "Close Other Windows", silent = true })
map("n", "<leader>w=", "<c-w>=", { desc = "Equalize Windows", silent = true })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map("n", "<leader>wh", "<cmd>wincmd H<cr>", { desc = "Move Window Right" })
map("n", "<leader>wj", "<cmd>wincmd J<cr>", { desc = "Move Window Doen" })
map("n", "<leader>wk", "<cmd>wincmd K<cr>", { desc = "Move to the Up" })
map("n", "<leader>wl", "<cmd>wincmd L<cr>", { desc = "Move to the Left" })

--------------------------------------------------------------------------------
-- Terminals
--------------------------------------------------------------------------------
map("n", "<leader>ms", "<cmd>split | terminal<cr>a", { desc = "Terminal Buffer (Horizontal Split)", silent = true })
map("n", "<leader>mv", "<cmd>vsplit | terminal<cr>a", { desc = "Terminal Buffer (Vertical Split)", silent = true })

--------------------------------------------------------------------------------
-- Lines
--------------------------------------------------------------------------------
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down", silent = true })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up", silent = true })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down", silent = true })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up", silent = true })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down", silent = true })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up", silent = true })
map("n", "<leader>il", "<cmd>call append(line('.'), '')<cr>", { desc = "Line Below", silent = true })
map("n", "<leader>iL", "<cmd>call append(line('.') - 1, '')<cr>", { desc = "Line Above", silent = true })

--------------------------------------------------------------------------------
-- Buffers
--------------------------------------------------------------------------------

-- Next / Last
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Other
map("n", "<leader>bo", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Save
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- New
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Yank Buffer Name
map({ "n" }, "<Leader>byn", function()
  vim.cmd(":let @+ = expand('%:t')")
  Snacks.notify.info("Buffer name", { title = "Yanked" })
end, { desc = "Yank Buffer Name" })

-- Yank Buffer Name (Full Path)
map({ "n" }, "<Leader>byN", function()
  vim.cmd(":let @+ = expand('%:p')")
  Snacks.notify.info("Buffer name", { title = "Yanked" })
end, { desc = "Yank Buffer Name (Full Path)" })

-- Yank Buffer Path
map({ "n" }, "<Leader>byp", function()
  vim.cmd(":let @+ = expand('%:h')")
  Snacks.notify.info("Buffer Path", { title = "Yanked" })
end, { desc = "Yank Buffer Path" })

-- Open README
-- map({ "n" }, "<leader>or", require("config.helpers").open_readme, { desc = "Readme" })

--------------------------------------------------------------------------------
-- Scratch Pads
--------------------------------------------------------------------------------

-- Transient Scrath Buffer
map("n", "<leader>oSh", function()
  require("bw.util.scratch-buffer").open_scratch_buffer("current_window")
end, { desc = "Open Scratch Buffer" })
map("n", "<leader>oSs", function()
  require("bw.util.scratch-buffer").open_scratch_buffer("split")
end, { desc = "Open Scratch Buffer (Horizontal Split)" })
map("n", "<leader>oSv", function()
  require("bw.util.scratch-buffer").open_scratch_buffer("vsplit")
end, { desc = "Open Scratch Buffer (Vertical Split)" })
map("n", "<leader>oSp", function()
  require("bw.util.scratch-buffer").open_scratch_buffer("popup")
end, { desc = "Open Scratch Buffer (Popup Window)" })

-- Persistent Scrath Pad
map("n", "<leader>osh", "<cmd>edit ~/data/projects/scratch/README.md<cr>", { desc = "Current Window" })
map("n", "<leader>oss", "<cmd>split ~/data/projects/scratch/README.md<cr>", { desc = "Horizontal Split" })
map("n", "<leader>osv", "<cmd>vsplit ~/data/projects/scratch/README.md<cr>", { desc = "Vertical Split" })
map("n", "<leader>osp", function()
  Snacks.win.new({
    file = vim.fn.expand("~/data/projects/scratch/README.md"),
    width = 0.6,
    max_width = 90,
    height = 0.6,
    border = "single",
    wo = {
      spell = false,
      wrap = false,
      signcolumn = "yes",
      statuscolumn = " ",
      conceallevel = 3,
    },
    bo = {
      modifiable = true,
    },
  })
end, { desc = "Popup Window" })

--------------------------------------------------------------------------------
-- Lists
--------------------------------------------------------------------------------
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Previous quickfix" })
map("n", "[q", "<cmd>cprev<cr>", { desc = "Next quickfix" })
map("n", "<leader>xj", "<cmd>jumps<cr>", { desc = "Jump List" })
map("n", "<leader>xc", "<cmd>jumps<cr>", { desc = "Jump List" })

--------------------------------------------------------------------------------
-- Quit the Vim
--------------------------------------------------------------------------------
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

--------------------------------------------------------------------------------
-- Highlights
--------------------------------------------------------------------------------
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

--------------------------------------------------------------------------------
-- Searching
--------------------------------------------------------------------------------
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")
map("n", "g#", "g#zz")
map("n", "g*", "g*zz")
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map("n", "{", "{zz")
map("n", "}", "}zz")

--------------------------------------------------------------------------------
-- Tabs
--------------------------------------------------------------------------------
map("n", "<leader>th", "<cmd>tabp<cr>", { desc = "Previous", silent = true })
map("n", "<leader>tl", "<cmd>tabn<cr>", { desc = "Next", silent = true })
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New", silent = true })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close", silent = true })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close Other Tabs", silent = true })

--------------------------------------------------------------------------------
-- Editing in Insert Mode
--------------------------------------------------------------------------------
-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

--------------------------------------------------------------------------------
-- Save
--------------------------------------------------------------------------------
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

--------------------------------------------------------------------------------
-- Keywordprg
--------------------------------------------------------------------------------
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

--------------------------------------------------------------------------------
-- Project Stuff
--------------------------------------------------------------------------------
map("n", "<leader>fp", function()
  require("telescope").extensions.project.project()
end, { desc = "Project", silent = true })

--------------------------------------------------------------------------------
-- Neotree Stuff
--------------------------------------------------------------------------------
if pcall(require, "neo-tree") then
  vim.keymap.set("n", "<leader>es", "<cmd>Neotree left<cr>", { desc = "Neotree Toggle" })
  vim.keymap.set("n", "<leader>ef", "<cmd>Neotree float<cr>", { desc = "Neotree Toggle" })
end

--------------------------------------------------------------------------------
-- Tmux Navigator Stuff
--------------------------------------------------------------------------------
if vim.g.loaded_tmux_navigator == 1 then
  vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
  vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
  vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
  vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })
end

--------------------------------------------------------------------------------
-- Zen Mode
--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>ux", function()
  local tmux = os.getenv("TMUX")
  if vim.g.zen_mode then -- restore status bars
    vim.opt.laststatus = vim.g.zen_mode_last_status
    if tmux then
      os.execute("tmux set -g status " .. vim.g.zen_mode_tmux_status_bar)
    end
    vim.g.zen_mode = false
  else -- Save state and turn stuff off
    vim.g.zen_mode_last_status = vim.opt.laststatus:get()
    vim.opt.laststatus = 0
    if tmux then
      vim.g.zen_mode_tmux_status_bar = vim.fn.system("tmux show -gv status")
      os.execute("tmux set -g status off")
    end
    vim.g.zen_mode = true
  end
end, { silent = true, desc = "Toggle TMUX Zen Mode" })

--------------------------------------------------------------------------------
-- Diagnostics
--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

--------------------------------------------------------------------------------
-- Reference
--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>sw", function()
  vim.cmd("!dict <cword>")
end, { desc = "Dictionary" })
