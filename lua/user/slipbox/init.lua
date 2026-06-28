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

--- Extracts the `related` field from YAML front matter at the top of `lines`.
--- Supports both inline format (related: [foo, bar]) and block format:
--- related:
---   - foo
---   - bar
--- Pure (takes the lines rather than reading the buffer) so it is unit-testable.
---@param lines string[] buffer lines, front matter expected at the top
---@return string[] slip_ids a list of related slip IDs, or empty table if none are found
M.extract_yaml_related = function(lines)
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

--- Extracts related slip IDs from the current buffer's YAML front matter.
--- Warns and returns an empty list if the current buffer is not a slip README.
---@return table List of related slip IDs from the current slip (empty if not a slip)
M.get_related_slips = function()
  if not M.slip_id_from_path(vim.api.nvim_buf_get_name(0)) then
    vim.notify("Current buffer is not a slip.", vim.log.levels.WARN, { title = "Slipbox" })
    return {}
  end
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  return M.extract_yaml_related(lines)
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

--- Extracts a slip ID from a slip's README.md buffer path within the slipbox.
--- The slipbox root is escaped with vim.pesc so directories containing Lua
--- pattern magic characters (e.g. "-", ".") are matched literally.
---@param bufname string Absolute path to a buffer
---@return string|nil slip_id, or nil if the path is not a slip README
M.slip_id_from_path = function(bufname)
  local root = M.get_slipbox_path()
  if root == "" then
    return nil
  end
  local relative = bufname:gsub("^" .. vim.pesc(root) .. "/", "")
  return relative:match("^([%w%-]+)/README%.md$")
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
    return
  end
  if slip_id == "" then
    vim.notify("Invalid argument: slip_id is empty", vim.log.levels.ERROR, { title = "Slipbox" })
    return
  end
  if type(slip_id) ~= "string" then
    vim.notify("Invalid argument: slip_id expected to be a string", vim.log.levels.ERROR, { title = "Slipbox" })
    return
  end

  local slip_path = M.get_slip_path(slip_id)
  if vim.fn.filereadable(slip_path) == 1 then
    -- `{ args = { path } }` fnameescapes the path, so spaces/special chars are safe.
    vim.cmd.edit({ args = { slip_path } })
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

-- Opens a link in a slip
--
-- 1. Priority order: inline links [text](url) are checked before reference links
--    [text][id] because they share a common prefix, and we want the more specific
--    match first.
-- 2. vim.ui.open is used as the fallback rather than feedkeys("gx") which would
--    cause an infinite loop. It's the same underlying function modern neovim's
--    gx calls internally.
-- 3. vim.pesc escapes the reference ID before using it as a Lua pattern, so IDs
--    with special characters like `-` or `.` don't break the search.
-- 4. The function is extracted as a named local so it's easier to test
--    independently from the autocmd — call `:lua open_markdown_link()` to debug.
-- 5. Image links ![text](url) are handled by the same inline pattern as regular
--    links, with an optional leading `!` in the pattern.
-- 6. Relative paths are resolved by prepending the buffer's parent directory name
--    (the GUID directory) so that xdg-open receives a path that works relative to
--    the slipbox root, which is where neovim's cwd will be for linting to work.
local function open_markdown_link()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- convert to 1-indexed
  local buf_dir = vim.fn.expand("%:p:h")
  local parent_dir_name = vim.fn.fnamemodify(buf_dir, ":t") -- just the GUID dir name

  local function resolve(path)
    if path:match("^https?://") or path:match("^ftp://") or path:match("^mailto:") then
      return path -- absolute URL, use as-is
    end
    if path:match("^/") then
      return path -- absolute path, use as-is
    end
    return parent_dir_name .. "/" .. path -- prepend GUID dir name for relative paths
  end

  local url = nil

  -- 1. Try inline markdown link [text](url) or image link ![text](url)
  local pos = 1
  while pos <= #line do
    local s, e, link_url = line:find("!?%[.-%]%((.-)%)", pos)
    if not s then
      break
    end
    if col >= s and col <= e then
      url = resolve(link_url)
      break
    end
    pos = e + 1
  end

  -- 2. Try reference link [text][id] → look up definition in buffer
  if not url then
    pos = 1
    while pos <= #line do
      local s, e, ref_id = line:find("%[.-%]%[(.-)%]", pos)
      if not s then
        break
      end
      if col >= s and col <= e then
        for _, bline in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
          local ref_url = bline:match("^%[" .. vim.pesc(ref_id) .. "%]:%s*(.+)$")
          if ref_url then
            url = resolve(vim.trim(ref_url))
            break
          end
        end
        break
      end
      pos = e + 1
    end
  end

  -- 3. Try plain URL under cursor
  if not url then
    local cfile = vim.fn.expand("<cfile>")
    if cfile:match("^https?://") or cfile:match("^ftp://") or cfile:match("^mailto:") then
      url = cfile
    end
  end

  if url then
    vim.fn.jobstart({ "xdg-open", url }, { detach = true })
  else
    vim.ui.open(vim.fn.expand("<cfile>")) -- fall back to default gx behavior
  end
end

--- Initializes the slipbox module with configuration and user commands
--- Creates SlipNew and SlipEdit commands, sets up auto-save functionality,
--- and validates the slipbox directory exists
---@param opts table Configuration table with slipbox_dir field required
function M.setup(opts)
  -- Normalize early so "~" and env vars resolve everywhere downstream
  -- (autocmd patterns, path stripping, get_slip_path) and so the directory
  -- validation below checks the real, resolved path.
  if opts and type(opts.slipbox_dir) == "string" then
    opts.slipbox_dir = vim.fs.normalize(opts.slipbox_dir)
  end

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
      local slip_id = M.slip_id_from_path(bufname)
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

  -- Open Link In Slip
  local slip_link_group = vim.api.nvim_create_augroup("SlipLinkHandler", { clear = true })
  vim.api.nvim_create_autocmd("BufEnter", {
    group = slip_link_group,
    pattern = M.get_slipbox_path() .. "/**/README.md",
    callback = function()
      vim.keymap.set("n", "gx", open_markdown_link, {
        buffer = true,
        desc = "Open markdown link under cursor (slipbox)",
      })
    end,
  })

  state.loaded = true
end

return M
