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
    opts = {
      picker = {
        sources = {
          ["slipbox"] = { -- This is the name displayed in the picker

            -- Logic to find and return the items.
            -- This function should return an iterable (e.g., a table) of items.
            -- Each item can be a string or a table with a 'text' field.
            finder = function(opts, ctx)
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

            -- Action to perform when an item is selected.
            -- `picker` is the picker instance, `item` is the selected item.
            -- confirm = function(picker, item)
            --   print("Selected: " .. item)
            --   picker:close() -- Close the picker after selection
            -- end,

            -- Optional parameter title: string (override the source name as title)
            title = "Slipbox",

            -- Other optional parameters:
            -- layout: string (e.g., "select", "vscode")
            -- live: boolean (for live filtering)
            -- supports_live: boolean (if the finder supports live updates)
            -- layout: string (e.g., "select", "vscode")
          },
        },
      },
    },
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
