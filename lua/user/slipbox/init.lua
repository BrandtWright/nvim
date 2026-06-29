local M = {}

local toast = require("bw.util.notification")

-- Default on-disk location of the slipbox. This is a domain default, not plugin
-- coupling: it lets the path readers below resolve a sensible directory even if
-- a caller reaches them before setup() has run (belt-and-suspenders -- the real
-- call sites load the plugin, which runs setup() first). setup() overrides it
-- with the configured value. Exposed so the plugin spec reuses this one
-- definition instead of duplicating the path.
local DEFAULT_SLIPBOX_DIR = vim.fs.normalize("~/data/base/slipbox")
M.default_slipbox_dir = DEFAULT_SLIPBOX_DIR

local state = {
  loaded = false,
  -- Seed with the default so the dir readers (get_slip_path, slip_id_from_path,
  -- get_slipbox_path) never read nil -- and resolve correctly -- when invoked
  -- before setup().
  config = { slipbox_dir = DEFAULT_SLIPBOX_DIR },
}

--- Configures module options with defaults, executed only once during setup
---@param opts table Configuration options to merge with defaults
local function configure_opts(opts)
  if state.loaded then
    return
  end
  state.config = vim.tbl_deep_extend("force", {
    slipbox_dir = DEFAULT_SLIPBOX_DIR,
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

--- Gets the next available slip ID from the external snote command.
--- Returns nil (rather than snote's error text) when snote is missing or fails,
--- so callers don't treat an error message as a slip ID / filesystem path.
---@return string|nil slip_id Next slip ID, or nil if snote failed or produced nothing
M.get_next_slip_id = function()
  local id = vim.fn.trim(vim.fn.system({ "snote", "-n" }))
  if vim.v.shell_error ~= 0 or id == "" then
    return nil
  end
  return id
end

--- Extracts related slip IDs from the current buffer's YAML front matter.
--- Warns and returns an empty list if the current buffer is not a slip README.
---@return table List of related slip IDs from the current slip (empty if not a slip)
M.get_related_slips = function()
  if not M.slip_id_from_path(vim.api.nvim_buf_get_name(0)) then
    toast.warn("Current buffer is not a slip.", "Slipbox")
    return {}
  end
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  return M.extract_yaml_related(lines)
end

--- Parses snote's `ID<tab>TITLE<tab>TAGS` lines into records. Blank lines (e.g.
--- a trailing newline from snote) are skipped so they don't yield junk records.
--- Pure, so it is unit-testable without invoking snote.
---@param lines string[] Raw lines from `snote -l`
---@return { id: string, title: string, tags: string }[]
function M.parse_slip_lines(lines)
  local records = {}
  for _, line in ipairs(lines) do
    local fields = vim.split(line, "\t", { plain = true })
    if fields[1] and fields[1] ~= "" then
      table.insert(records, { id = fields[1], title = fields[2] or "", tags = fields[3] or "" })
    end
  end
  return records
end

--- Lists all slips via the external snote command, parsed into records so
--- callers need not know snote's `ID<tab>TITLE<tab>TAGS` line format. Uses the
--- argv form (no shell) and checks shell_error, returning an empty list rather
--- than letting snote's error text (e.g. "sh: snote: not found") be parsed into
--- a bogus record -- mirrors the handling in get_next_slip_id.
---@return { id: string, title: string, tags: string }[]
function M.list_slips()
  local lines = vim.fn.systemlist({ "snote", "-l" })
  if vim.v.shell_error ~= 0 then
    return {}
  end
  return M.parse_slip_lines(lines)
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
---@return string|nil slip_id Slip ID or nil if the path is not a slip README
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
  if not slip_id then
    toast.error("Could not generate a slip ID (is `snote` installed and working?).", "Slipbox")
    return
  end
  local slip_path = M.get_slip_path(slip_id)
  vim.cmd("enew")
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(bufnr, slip_path)
  vim.api.nvim_set_option_value("buftype", "", { buf = bufnr })
  vim.api.nvim_set_option_value("swapfile", false, { buf = bufnr })
  -- Intentionally NOT bufhidden=wipe: with the global 'hidden' on, an abandoned
  -- new slip survives in the background (and prompts on quit if modified) rather
  -- than being silently discarded when you navigate away before the first :w.
  vim.api.nvim_set_option_value("filetype", "markdown", { buf = bufnr })
end

--- Opens an existing slip for editing by its ID
--- Validates the slip exists before opening and configures buffer options
---@param slip_id string The slip identifier to edit
M.edit_slip = function(slip_id)
  -- Validate type first (this also rules out nil), then non-empty -- so the
  -- guards run most-fundamental-first rather than type-checking last.
  if type(slip_id) ~= "string" then
    toast.error("Invalid argument: slip_id expected to be a string", "Slipbox")
    return
  end
  if slip_id == "" then
    toast.error("Invalid argument: slip_id is empty", "Slipbox")
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
    toast.error("Slip with ID '" .. slip_id .. "' does not exist.", "Slipbox", "")
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
    toast.error("Slipbox setup requires a valid 'slipbox_dir' option that points to an existing directory.", "Slipbox")
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
        toast.error("Invalid slipbox file path.", "Slipbox")
        return
      end

      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local content = table.concat(lines, "\n")
      if vim.bo[bufnr].eol then
        content = content .. "\n"
      end

      -- Bounded so a wedged snote (e.g. hung on a locked store) fails the write
      -- with an error toast instead of freezing the UI on the synchronous :wait.
      local result = vim.system({ "snote", "-s", slip_id }, { stdin = content }):wait(5000)
      if result.code ~= 0 then
        -- stderr can be nil on some failure paths; guard the concat.
        toast.error("Failed to save file: " .. (result.stderr or ""), "Slipbox")
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
