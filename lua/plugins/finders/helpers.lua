local M = {}

-------------------------------------------------------------------------------
--  Standard
-------------------------------------------------------------------------------
function M.find_files(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  require("telescope.builtin").find_files(opts)
end

function M.ivy(opts)
  local themes = require("telescope.themes")
  opts = opts or {}
  local defaults = themes.get_ivy({ hidden = false })
  opts = vim.tbl_deep_extend("force", defaults, opts)
  require("telescope.builtin").find_files(opts)
end

function M.current_buffer_fuzzy_find() end

-------------------------------------------------------------------------------
--  Notification
-------------------------------------------------------------------------------
function M.notifications(opts)
  opts = opts or {}
  vim.cmd("Telescope notify")
end

-------------------------------------------------------------------------------
--  Grep
-------------------------------------------------------------------------------
function M.grep_file_type(opts)
  opts = opts or {}
  local defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--type",
      vim.fn.input("Type: "),
    },
  }
  opts = vim.tbl_deep_extend("force", defaults, opts)
  require("telescope.builtin").live_grep(opts)
end

function M.rg_location_prompt(opts)
  opts = opts or {}
  local defaults = {
    cwd = vim.fn.input("Directory: "),
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
  }
  opts = vim.tbl_deep_extend("force", defaults, opts)
  require("telescope.builtin").live_grep(opts)
end

-------------------------------------------------------------------------------
--  Spell
-------------------------------------------------------------------------------
function M.spell_suggest()
  local themes = require("telescope.themes")
  local opts = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    layout_config = {
      width = 0.5,
    },
  })
  require("telescope.builtin").spell_suggest(opts)
end

-------------------------------------------------------------------------------
--  Dotfiles
-------------------------------------------------------------------------------
function M.find_dotfiles(opts)
  local pickers = require("telescope.pickers")
  local conf = require("telescope.config").values
  opts = opts or {}
  local locs = vim.fn.systemlist("/home/brandt/.local/bin/dotfiles")
  pickers
    .new({}, {
      prompt_title = "Find Files (Dotfiles)",
      finder = require("telescope.finders").new_table(locs),
      sorter = conf.file_sorter(opts),
      previewer = conf.file_previewer(opts),
    })
    :find()
end

function M.local_bin(opts)
  local pickers = require("telescope.pickers")
  local conf = require("telescope.config").values
  opts = opts or {}
  local locs = vim.fn.systemlist("/home/brandt/.local/bin/scripts")
  pickers
    .new({}, {
      prompt_title = "Find Files ($HOME/.local/bin)",
      finder = require("telescope.finders").new_table(locs),
      sorter = conf.file_sorter(opts),
      previewer = conf.file_previewer(opts),
    })
    :find()
end
-------------------------------------------------------------------------------
--  Diagnostics
-------------------------------------------------------------------------------
function M.document_diagnostics()
  vim.cmd("Telescope diagnostics bufnr=0")
end

function M.workspace_diagnostics()
  vim.cmd("Telescope diagnostics bufnr=0")
end

-------------------------------------------------------------------------------
--  Extensions
-------------------------------------------------------------------------------
function M.emoji()
  vim.cmd("Telescope emoji")
end

-------------------------------------------------------------------------------
--  Slipbox
-------------------------------------------------------------------------------

local get_zettle_path = function(entry)
  local _, j = string.find(entry, ":")
  local path = string.sub(entry, 1, j - 1)
  return path
end

local get_zettle_title = function(entry)
  local _, j = string.find(entry, ":")
  local remaining = string.sub(entry, j + 1)
  _, j = string.find(remaining, ":")
  local title = string.sub(remaining, 1, j - 1)
  return title
end

function M.find_zettel(opts)
  local pickers = require("telescope.pickers")
  local conf = require("telescope.config").values
  local finders = require("telescope.finders")
  opts = opts or {}
  opts.entry_maker = function(entry)
    return {
      value = entry,
      display = get_zettle_title(entry),
      ordinal = entry,
      path = get_zettle_path(entry),
    }
  end
  pickers
    .new(opts, {
      prompt_title = "Notes",
      finder = finders.new_oneshot_job({ "zet", "-i" }, opts),
      previewer = conf.file_previewer(opts),
      sorter = conf.generic_sorter(opts),
    })
    :find()
end

function M.link_zettel(opts)
  opts = opts or {}

  local pickers = require("telescope.pickers")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local finders = require("telescope.finders")

  opts.entry_maker = function(entry)
    return {
      value = entry,
      display = get_zettle_title(entry),
      ordinal = entry,
      path = get_zettle_path(entry),
    }
  end
  pickers
    .new(opts, {
      prompt_title = "Notes",
      finder = finders.new_oneshot_job({ "zet", "-i" }, opts),
      previewer = conf.file_previewer(opts),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          vim.cmd("r ! zet -k " .. get_zettle_path(selection.value))
        end)
        return true
      end,
    })
    :find()
end

return setmetatable({}, {
  __index = function(_, k)
    if M[k] then
      return M[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})
