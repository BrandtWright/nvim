local M = {}

local state = {
  loaded = false,
  config = {},
}

local function configure_opts(opts)
  if state.loaded then
    return
  end
  state.config = vim.tbl_deep_extend("force", {
    slipbox_dir = "",
  }, opts or {})
end

local function convert_slip_id_to_slip_path(slip_id)
  return state.config.slipbox_dir .. "/" .. slip_id .. "/README.md"
end

M.get_next_slip_id = function()
  return vim.fn.trim(vim.fn.system({ "snote", "-n" }))
end

function M.list_slips()
  local slips = vim.fn.systemlist("snote -l")
  return slips
end

M.get_slipbox_path = function()
  return state.config.slipbox_dir
end

M.new_slip = function()
  local slip_id = M.get_next_slip_id()
  local slip_path = convert_slip_id_to_slip_path(slip_id)
  vim.cmd("enew")
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(bufnr, slip_path)
  vim.api.nvim_set_option_value("buftype", "", { buf = bufnr })
  vim.api.nvim_set_option_value("swapfile", false, { buf = bufnr })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bufnr })
  vim.api.nvim_set_option_value("filetype", "markdown", { buf = bufnr })
end

M.edit_slip = function(slip_id)
  if not slip_id then
    vim.notify("Invalid argument: slip_id is nil", vim.log.levels.ERROR, { title = "Slipbox" })
  end
  if slip_id == "" then
    vim.notify("Invalid argument: slip_id is empty", vim.log.levels.ERROR, { title = "Slipbox" })
  end
  if type(slip_id) ~= "string" then
    vim.notify("Invalid argument: slip_id expected to be a string", vim.log.levels.ERROR, { title = "Slipbox" })
  end

  local slip_path = convert_slip_id_to_slip_path(slip_id)
  if vim.fn.filereadable(slip_path) == 1 then
    vim.cmd("edit " .. slip_path)
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_set_option_value("buftype", "", { buf = bufnr })
    vim.api.nvim_set_option_value("swapfile", false, { buf = bufnr })
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bufnr })
    vim.api.nvim_set_option_value("filetype", "markdown", { buf = bufnr })
  else
    vim.notify(
      "Slip with ID '" .. slip_id .. "' does not exist.",
      vim.log.levels.ERROR,
      { title = "Slipbox", icon = "" }
    )
  end
end

function M.setup(opts)
  -- Ensure that opts.slipbox_dir is set, is a string, and points to a valid directory
  if
    not opts
    or type(opts.slipbox_dir) ~= "string"
    or opts.slipbox_dir == ""
    or not vim.uv.fs_stat(opts.slipbox_dir)
    or vim.uv.fs_stat(opts.slipbox_dir).type ~= "directory"
  then
    vim.notify(
      "Slipbox setup requires a valid 'slipbox_dir' option that points to an existing directory.",
      vim.log.levels.ERROR,
      { title = "Slipbox" }
    )
    return
  end

  configure_opts(opts)

  -- New Slip
  vim.api.nvim_create_user_command("SlipNew", M.new_slip, { nargs = 0, desc = "Create a new slip" })

  -- Edit Slip
  vim.api.nvim_create_user_command("SlipEdit", function(args)
    M.edit_slip(args.args)
  end, { nargs = 1, desc = "Edit slip with ID" })

  -- Save Slip
  local group = vim.api.nvim_create_augroup("SlipWrite", { clear = true })
  vim.api.nvim_create_autocmd("BufWriteCmd", {
    group = group,
    pattern = M.get_slipbox_path() .. "/*/README.md",
    callback = function(args)
      local bufnr = args.buf
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local relative = bufname:gsub("^" .. M.get_slipbox_path() .. "/", "")
      local slip_id = relative:match("^([%w%-]+)/README%.md$")
      if not slip_id then
        vim.notify("Invalid slipbox file path.", vim.log.levels.ERROR, { title = "Slipbox" })
        return
      end

      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local content = table.concat(lines, "\n")
      if vim.bo[bufnr].eol then
        content = content .. "\n"
      end

      local result = vim.system({ "snote", "-s", slip_id }, { stdin = content }):wait()
      if result.code ~= 0 then
        vim.notify("Failed to save file: " .. result.stderr, vim.log.levels.ERROR)
        return
      end

      vim.api.nvim_set_option_value("modified", false, { buf = bufnr })

      -- Fire BufWritePost for plugins that need to know layout
      -- writes taking place
      vim.api.nvim_exec_autocmds("BufWritePost", {
        buffer = bufnr,
        modeline = false,
      })
    end,
  })

  -- Find Slip
  vim.api.nvim_create_user_command("SlipFind", function()
    -- Field Parser
    local function split(str, sep)
      local fields = {}
      for field in string.gmatch(str, "([^" .. sep .. "]+)") do
        table.insert(fields, field)
      end
      return fields
    end

    -- Slip List
    local slips = M.list_slips()

    -- Picker Config
    local items = {}
    for _, v in ipairs(slips) do
      local fields = split(v, "\t")
      local slip_id = fields[1]
      local title = fields[2]
      local tags = fields[3] or ""
      table.insert(items, {
        text = title .. " " .. tags,
        name = slip_id,
        file = convert_slip_id_to_slip_path(slip_id),
        filetype = "markdown",
        action = function()
          vim.cmd("SlipEdit " .. slip_id)
        end,
      })
    end

    -- Picker Action
    Snacks.picker({
      items = items,
      source = "Slipbox", -- Optional source name
      -- layout = {
      --   fullscreen = true,
      -- },
      format = function(item)
        return { { item.text } }
      end,
      confirm = function(picker, item)
        -- Code to execute when an item is confirmed (selected)
        picker:close()
        if item.action then
          item.action()
        end
      end,
    })
  end, {
    nargs = 0,
    desc = "Find Slips",
  })

  state.loaded = true
end

return M
