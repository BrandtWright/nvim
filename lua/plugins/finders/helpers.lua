local M = {}

-------------------------------------------------------------------------------
--  Notification
-------------------------------------------------------------------------------
function M.notifications(opts)
  opts = opts or {}
  vim.cmd("Telescope notify")
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
