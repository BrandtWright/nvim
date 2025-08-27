local M = {}

local state = {
  loaded = false,
  config = {},
}

--- Configures module options with defaults, executed only once during setup
---@param opts table Configuration options to merge with defaults
local function configure_opts(opts)
  if state.loaded then
    return
  end
  state.config = vim.tbl_deep_extend("force", {
    slipbox_dir = "",
  }, opts or {})
end

--- Extracts `related` field from YAML front matter at the top of current buffer
--- Supports both inline format (related: [foo, bar]) and block format:
--- related:
---   - foo
---   - bar
---@return string[] slip_ids a list of related slip IDs, or empty table if none are found
local function extract_yaml_related()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local in_yaml = false
  local related = {}
  local i = 1

  while i <= #lines do
    local line = vim.trim(lines[i])

    -- Start YAML front matter
    if not in_yaml then
      if line == "---" then
        in_yaml = true
      else
        break -- No front matter at top
      end
    else
      -- End YAML front matter
      if line == "---" or line == "..." then
        break
      end

      -- Inline list: related: [foo, bar]
      local inline = line:match("^related:%s*%[(.-)%]")
      if inline then
        for item in inline:gmatch("[^,%s]+") do
          table.insert(related, item)
        end
      end

      -- Block list: related: then indented - item entries
      local is_block_list = line:match("^related:%s*$")
      if is_block_list then
        i = i + 1
        while i <= #lines do
          local tag_line = vim.trim(lines[i])

          -- stop if we hit end of YAML or another property
          if tag_line == "---" or tag_line == "..." or tag_line:match("^[%w_]+:") then
            break
          end

          -- only match lines like "- something" (not "---")
          local item = tag_line:match("^%-%s+(.+)")
          if item then
            table.insert(related, item)
          else
            break
          end

          i = i + 1
        end
        break -- stop after block list
      end
    end

    i = i + 1
  end

  return related
end

--- Constructs the full filesystem path for a slip by its ID
---@param slip_id string The slip identifier
---@return string Full path to the slip's README.md file
M.get_slip_path = function(slip_id)
  return state.config.slipbox_dir .. "/" .. slip_id .. "/README.md"
end

--- Gets the next available slip ID from the external snote command
---@return string Next slip ID to use for new slips
M.get_next_slip_id = function()
  return vim.fn.trim(vim.fn.system({ "snote", "-n" }))
end

--- Extracts related slip IDs from the current buffer's YAML front matter
---@return table List of related slip IDs from the current slip
M.get_related_slips = function()
  -- TODO: sanity check current buffer, warn if not a slip...
  local related_slip_ids = extract_yaml_related()
  return related_slip_ids
end

--- Lists all available slips using the external snote command
---@return table List of all slip IDs in the slipbox
function M.list_slips()
  local slips = vim.fn.systemlist("snote -l")
  return slips
end

--- Gets the configured slipbox directory path
---@return string Path to the slipbox directory
M.get_slipbox_path = function()
  return state.config.slipbox_dir
end

--- Creates a new slip with auto-generated ID and opens it for editing
--- Sets up the buffer with proper options and configures it as a markdown file
M.new_slip = function()
  local slip_id = M.get_next_slip_id()
  local slip_path = M.get_slip_path(slip_id)
  vim.cmd("enew")
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(bufnr, slip_path)
  vim.api.nvim_set_option_value("buftype", "", { buf = bufnr })
  vim.api.nvim_set_option_value("swapfile", false, { buf = bufnr })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bufnr })
  vim.api.nvim_set_option_value("filetype", "markdown", { buf = bufnr })
end

--- Opens an existing slip for editing by its ID
--- Validates the slip exists before opening and configures buffer options
---@param slip_id string The slip identifier to edit
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

  local slip_path = M.get_slip_path(slip_id)
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

--- Initializes the slipbox module with configuration and user commands
--- Creates SlipNew and SlipEdit commands, sets up auto-save functionality,
--- and validates the slipbox directory exists
---@param opts table Configuration table with slipbox_dir field required
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
  end, { nargs = 1, desc = "Edit slip by ID" })

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

  state.loaded = true
end

return M
