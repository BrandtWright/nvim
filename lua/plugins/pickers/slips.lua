-------------------------------------------------------------------------------
-- Fuzzy Find Slips
-------------------------------------------------------------------------------

return {
  {
    "folke/snacks.nvim",
    dependencies = {
      name = "slipbox",
      dir = vim.fn.stdpath("config") .. "/lua/user/slipbox",
    },
    opts = function(_, opts)
      -- Buffer-local mappings for slip buffers. Asking the slipbox module whether
      -- a buffer is a slip keeps the on-disk layout knowledge in the module and
      -- avoids depending on setup() having run before these opts are evaluated.
      vim.api.nvim_create_autocmd("BufReadPost", {
        group = vim.api.nvim_create_augroup("SlipboxBuffLocalKeyMaps", { clear = true }),
        pattern = "*",
        callback = function(ev)
          local slipbox = require("user.slipbox")
          local slip_id = slipbox.slip_id_from_path(vim.api.nvim_buf_get_name(ev.buf))
          if slip_id then
            local ok, wk = pcall(require, "which-key")
            if ok then
              wk.add({
                {
                  "<localleader>s",
                  function()
                    vim.fn.setreg("+", slip_id)
                    vim.notify(slip_id, vim.log.levels.INFO, { title = "Yanked Slip Id" })
                  end,
                  buffer = ev.buf,
                  desc = "Yank slip ID",
                },
                {
                  "<localleader>v",
                  function()
                    Snacks.picker.pick({ source = "related_slips" })
                  end,
                  buffer = ev.buf,
                  desc = "View Related Slips",
                },
                {
                  "<localleader>a",
                  function()
                    Snacks.picker.pick({ source = "slip_links" })
                  end,
                  buffer = ev.buf,
                  desc = "Add Related Slip",
                },
              })
            end
          end
        end,
      })

      local my_opts = {
        picker = {
          enabled = true,
          sources = {
            slipbox = { -- This is the name displayed in the picker

              -- Logic to find and return the items.
              -- This function should return an iterable (e.g., a table) of items.
              -- Each item can be a string or a table with a 'text' field.
              finder = function()
                local slipbox = require("user.slipbox")
                local items = {}
                for _, slip in ipairs(slipbox.list_slips()) do
                  table.insert(items, {
                    text = slip.title .. " " .. slip.tags,
                    name = slip.id,
                    file = slipbox.get_slip_path(slip.id),
                    filetype = "markdown",
                  })
                end
                return items
              end,

              -- Optional: Customize how each item is displayed in the picker.
              -- This function takes an item and returns a formatted string or a table
              -- suitable for `vim.api.nvim_buf_set_text`.
              format = function(item)
                return { { item.text } }
              end,

              -- Optional parameter title: string (override the source name as title)
              title = "Slipbox",

              -- Other optional parameters:
              -- layout: string (e.g., "select", "vscode")
              -- live: boolean (for live filtering)
              -- supports_live: boolean (if the finder supports live updates)
            },
            related_slips = {
              finder = function()
                local slipbox = require("user.slipbox")
                local slips = slipbox.get_related_slips()
                local items = {}
                for _, v in ipairs(slips) do
                  local slip_path = slipbox.get_slip_path(v)
                  table.insert(items, {
                    text = v,
                    name = v,
                    file = slip_path,
                    filetype = "markdown",
                  })
                end
                return items
              end,
              format = function(item)
                return { { item.text } }
              end,
              title = "Related Slips",
            },

            slip_links = { -- This is the name displayed in the picker

              -- Logic to find and return the items.
              -- This function should return an iterable (e.g., a table) of items.
              -- Each item can be a string or a table with a 'text' field.
              finder = function()
                local slipbox = require("user.slipbox")
                local related_slips = slipbox.get_related_slips()
                local items = {}
                for _, slip in ipairs(slipbox.list_slips()) do
                  -- don't add slips that are already related
                  if not vim.tbl_contains(related_slips, slip.id) then
                    table.insert(items, {
                      text = slip.title .. " " .. slip.tags,
                      name = slip.id,
                      file = slipbox.get_slip_path(slip.id),
                      filetype = "markdown",
                      action = function()
                        local row = vim.api.nvim_win_get_cursor(0)[1] -- current line (1-based)
                        local text = string.format("  - %s", slip.id)
                        vim.api.nvim_buf_set_lines(0, row, row, false, { text })
                      end,
                    })
                  end
                end
                return items
              end,

              confirm = "item_action",
              format = function(item)
                return { { item.text } }
              end,

              title = "Link Slip",
            },
          },
        },
      }
      return vim.tbl_deep_extend("force", opts or {}, my_opts)
    end,
    keys = {
      {
        "<leader>sn",
        function()
          Snacks.picker.pick({ source = "slipbox" })
        end,
        desc = "Find Slip",
      },
    },
  },
}
