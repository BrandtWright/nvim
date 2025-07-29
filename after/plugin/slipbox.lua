local can_tele = function()
  local has, tele = pcall(require("telescope.builtin"))
  if not has then
    local msg = "Telescope not found."
    vim.notify(msg, vim.log.levels.ERROR, { title = "Slipbox", icon = "" })
  end
  return has, tele
end

local map_keys = function(lhs, rhs, description)
  vim.keymap.set("n", lhs, rhs, { silent = true, desc = description })
end

local edit = function(path)
  vim.cmd(string.format("e %s", path))
end

local slipbox_command = function(flag)
  return vim.fn.system(string.format("$HOME/.local/bin/zet %s", flag))
end

local find_slip = function()
  if not can_tele then
    return
  end
  require("plugins.finders.helpers").find_zettel()
end

local link_slip = function()
  if not can_tele then
    return
  end
  require("plugins.finders.helpers").link_zettel()
end

local create_slip = function()
  edit(slipbox_command("-n"))
end

local create_temp_slip = function()
  edit(slipbox_command("-t"))
end

local create_reference_slip = function()
  edit(slipbox_command("-r"))
end

local create_literary_slip = function()
  edit(slipbox_command("-l"))
end

local actions = {
  note = create_slip,
  temporary = create_temp_slip,
  literary = create_literary_slip,
  reference = create_reference_slip,
  find = find_slip,
  link = link_slip,
}

local command_opts = {
  nargs = 1,
  complete = function(_, _, _)
    -- return completion candidates
    local args = {}
    for k, _ in pairs(actions) do
      table.insert(args, k)
    end
    return args
  end,
}

local command_handler = function(opts)
  for k, v in pairs(actions) do
    if opts.fargs[1] == k then
      v()
      return
    end
  end

  vim.notify(
    string.format("Invalid note type: %s", opts.fargs[1]),
    vim.log.levels.ERROR,
    { title = "Slipbox", icon = "" }
  )
end

-- vim.api.nvim_create_user_command("Slipbox", command_handler, command_opts)

-- map_keys("<leader>fz", function()
--   find_slip()
-- end, "Find Slip")
--
-- map_keys("<leader>zk", function()
--   link_slip()
-- end, "Link Slip")
--
-- map_keys("<leader>zn", function()
--   create_slip()
-- end, "Create Slip")
--
-- map_keys("<leader>zt", function()
--   create_temp_slip()
-- end, "Create Temporary Slip")
--
-- map_keys("<leader>zr", function()
--   create_reference_slip()
-- end, "Create Reference Slip")
--
-- map_keys("<leader>zl", function()
--   create_literary_slip()
-- end, "Create Literature Slip")
