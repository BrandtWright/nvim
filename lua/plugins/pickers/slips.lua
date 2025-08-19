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
      -- Set up bufer local mappings for slips in the slipbox path
      local slipbox_path = vim.fn.expand(require("user.slipbox").get_slipbox_path())
      local slipbox_pattern = vim.pesc(slipbox_path) .. "/[^/]+/README%.md$"
      vim.api.nvim_create_autocmd("BufReadPost", {
        group = vim.api.nvim_create_augroup("SlipboxBuffLocalKeyMaps", { clear = true }),
        pattern = "*",
        callback = function(ev)
          local path = vim.api.nvim_buf_get_name(ev.buf)
          if path:match(slipbox_pattern) then
            local ok, wk = pcall(require, "which-key")
            if ok then
              wk.add({
                "<leader>sR",
                function()
                  Snacks.picker.pick({ source = "related_slips" })
                end,
                buffer = ev.buf,
                desc = "View Related Slips",
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
                -- Slip list field parser (splits ID<tab>TITLE<tab>TAGS)
                local function split(str, sep)
                  local fields = {}
                  for field in string.gmatch(str, "([^" .. sep .. "]+)") do
                    table.insert(fields, field)
                  end
                  return fields
                end

                -- Get slips
                local slipbox = require("user.slipbox")
                local slips = slipbox.list_slips()

                -- Configure picker items
                local items = {}
                for _, v in ipairs(slips) do
                  local fields = split(v, "\t")
                  local slip_id = fields[1]
                  local slip_path = slipbox.get_slip_path(slip_id)
                  local title = fields[2]
                  local tags = fields[3] or ""
                  table.insert(items, {
                    text = title .. " " .. tags,
                    name = slip_id,
                    file = slip_path,
                    filetype = "markdown",
                    action = function()
                      vim.cmd("edit " .. slip_path)
                    end,
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
                    action = function()
                      vim.cmd("edit " .. slip_path)
                    end,
                  })
                end
                return items
              end,
              format = function(item)
                return { { item.text } }
              end,
              title = "Related Slips",
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
