-- Ansible buffers carry the compound filetype `yaml.ansible`; Neovim sources
-- this ftplugin for the `ansible` component. The <localleader>a lint keymap
-- lives here rather than in mason's `opts` so it reliably attaches to the first
-- ansible buffer -- even when opening that buffer is what triggers mason and
-- nvim-lspconfig to load (in which case the FileType event has already fired by
-- the time mason's opts run).
vim.keymap.set("n", "<localleader>a", function()
  -- shellescape the path so spaces/metacharacters can't break the command.
  Snacks.terminal.open("ansible-lint " .. vim.fn.shellescape(vim.fn.expand("%")) .. " && anykey", {
    win = { border = "single", style = "terminal", relative = "editor", width = 120, height = 25 },
    interactive = true,
  })
end, { buffer = true, noremap = true, silent = true, desc = "Ansible Lint Buffer" })
