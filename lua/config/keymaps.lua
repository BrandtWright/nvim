--------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------
-- Loaded automatically on the VeryLazy event. Add any additional keymaps here;
-- mappings in this file win over LazyVim's defaults.
--
-- Inherited keymaps come from LazyVim. To see what's active:
--   :verbose nmap <key>        -- shows the mapping AND its source file:line
--   Snacks.picker.keymaps()    -- fuzzy-search everything
-- Source of the defaults
--   ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/config/keymaps.lua
--   https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

--------------------------------------------------------------------------------
-- Function Keys
--------------------------------------------------------------------------------
map("n", "<F7>", function()
  vim.cmd("setlocal spell!")
end, { desc = "Toggle Spell", silent = true })

--------------------------------------------------------------------------------
-- Movement
--------------------------------------------------------------------------------
-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "<C-n>", "j<C-e>", { desc = "Scroll Down" })
map("n", "<C-p>", "k<C-y>", { desc = "Scroll Up" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

--------------------------------------------------------------------------------
-- Windows
--------------------------------------------------------------------------------
map("n", "<leader>ws", "<cmd>split<cr>", { desc = "Horizontal Split", silent = true })
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical Split", silent = true })
map("n", "<leader>wd", "<c-w>c", { desc = "Delete Window", silent = true })
map("n", "<leader>wo", "<c-w>o", { desc = "Close Other Windows", silent = true })
map("n", "<leader>w=", "<c-w>=", { desc = "Equalize Windows", silent = true })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map("n", "<leader>wh", "<cmd>wincmd H<cr>", { desc = "Move Window Left" })
map("n", "<leader>wj", "<cmd>wincmd J<cr>", { desc = "Move Window Down" })
map("n", "<leader>wk", "<cmd>wincmd K<cr>", { desc = "Move Window Up" })
map("n", "<leader>wl", "<cmd>wincmd L<cr>", { desc = "Move Window Right" })

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

-- New
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Yank Buffer Path
map({ "n" }, "<Leader>byp", function()
  vim.cmd(":let @+ = expand('%:h')")
  Snacks.notify.info("Buffer Path", { title = "Yanked" })
end, { desc = "Yank Buffer Path" })

-- Yank Buffer Name
map({ "n" }, "<Leader>byn", function()
  vim.cmd(":let @+ = expand('%:t')")
  Snacks.notify.info("Buffer name", { title = "Yanked" })
end, { desc = "Yank Buffer Name" })

-- Yank Buffer Path and Name
map({ "n" }, "<Leader>byN", function()
  vim.cmd(":let @+ = expand('%:p')")
  Snacks.notify.info("Buffer name", { title = "Yanked" })
end, { desc = "Yank Buffer Name (Full Path)" })

--------------------------------------------------------------------------------
-- Scratch Pads
--------------------------------------------------------------------------------

-- Transient Scratch Buffer
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

-- Persistent Scratch Pad
local scratch_pad = vim.fn.expand("~/data/projects/scratch/README.md")
-- `{ args = { path } }` fnameescapes the path, so spaces/special chars are safe.
map("n", "<leader>osh", function()
  vim.cmd.edit({ args = { scratch_pad } })
end, { desc = "Current Window" })
map("n", "<leader>oss", function()
  vim.cmd.split({ args = { scratch_pad } })
end, { desc = "Horizontal Split" })
map("n", "<leader>osv", function()
  vim.cmd.vsplit({ args = { scratch_pad } })
end, { desc = "Vertical Split" })
map("n", "<leader>osp", function()
  Snacks.win.new({
    file = scratch_pad,
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
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next Quickfix" })
map("n", "[q", "<cmd>cprev<cr>", { desc = "Previous Quickfix" })
map("n", "<leader>xj", "<cmd>jumps<cr>", { desc = "Jump List" })
map("n", "<leader>xc", "<cmd>changes<cr>", { desc = "Change List" })

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
map("n", "<leader><tab>h", "<cmd>tabp<cr>", { desc = "Previous", silent = true })
map("n", "<leader><tab>l", "<cmd>tabn<cr>", { desc = "Next", silent = true })

--------------------------------------------------------------------------------
-- Editing in Insert Mode
--------------------------------------------------------------------------------
-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

--------------------------------------------------------------------------------
-- Keywordprg
--------------------------------------------------------------------------------
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

--------------------------------------------------------------------------------
-- Project Stuff
--------------------------------------------------------------------------------
map("n", "<leader>fp", function()
  Snacks.picker.projects()
end, { desc = "Project", silent = true })

--------------------------------------------------------------------------------
-- Tmux Navigator Stuff
--------------------------------------------------------------------------------
-- These deliberately live here rather than in the vim-tmux-navigator spec's
-- `keys`. config/keymaps.lua loads on VeryLazy, *after* LazyVim's own
-- config/keymaps.lua sets <C-h/j/k/l> to window navigation -- so these win by
-- load order. In the plugin spec's `keys` they'd register at startup (the
-- plugin is lazy=false) and LazyVim's VeryLazy maps would then clobber them.
-- vim-tmux-navigator is loaded unconditionally; outside tmux it falls back to
-- plain window navigation.
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true, desc = "Navigate Left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true, desc = "Navigate Down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true, desc = "Navigate Up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true, desc = "Navigate Right" })

--------------------------------------------------------------------------------
-- Zen Mode
--------------------------------------------------------------------------------
map("n", "<leader>ux", function()
  local tmux = os.getenv("TMUX")
  if vim.g.zen_mode then -- restore status bars
    vim.o.laststatus = vim.g.zen_mode_last_status
    if tmux then
      os.execute("tmux set -g status " .. vim.g.zen_mode_tmux_status_bar)
    end
    vim.g.zen_mode = false
  else -- Save state and turn stuff off
    vim.g.zen_mode_last_status = vim.o.laststatus
    vim.o.laststatus = 0
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
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

--------------------------------------------------------------------------------
-- Reference
--------------------------------------------------------------------------------
map("n", "<leader>sw", function()
  vim.cmd("!dict <cword>")
end, { desc = "Dictionary" })

--------------------------------------------------------------------------------
-- Overrides
--------------------------------------------------------------------------------
-- Override `gx` with with jobstart/detatch to avoid timeouts when the xdg
-- default application  takes a bit of time to start up.
map("n", "gx", function()
  local target = vim.fn.expand("<cfile>")
  vim.fn.jobstart({ "xdg-open", target }, { detach = true })
end, { desc = "Open with system handler" })

--------------------------------------------------------------------------------
-- Disabled Defaults
--------------------------------------------------------------------------------

-- Floating Terminal
pcall(vim.keymap.del, "n", "<leader>fT") -- use lua/plugins/floating-terminal.lua
