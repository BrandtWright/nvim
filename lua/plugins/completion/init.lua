local cmp = require("cmp")
local icons = require("lazyvim.config").icons.kinds
local colors = require("bw.config.colors")
vim.cmd("hi CmpItemAbbrMatch guifg=" .. colors.red)
for k, _ in pairs(icons) do
  local cmd = string.format("hi CmpItemKind%s guifg=%s", k, colors.gold)
  vim.cmd(cmd)
end

return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.preselect = cmp.PreselectMode.None
      opts.window = {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),

        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
      }
      opts.experimental = {}
    end,
  },
}
-- return {
--   {
--     "hrsh7th/nvim-cmp",
--     opts = function(_, opts)
--       local cmp = require("cmp")
--       local icons = require("lazyvim.config").icons.kinds
--       local colors = require("bw.config.colors")
--
--       vim.cmd("hi CmpItemAbbrMatch guifg=" .. colors.red)
--       for k, _ in pairs(icons) do
--         local cmd = string.format("hi CmpItemKind%s guifg=%s", k, colors.gold)
--         vim.cmd(cmd)
--       end
--
--       -- local sources = {
--       --   { name = "nvim_lsp_signature_help" },
--       --   { name = "nvim_lsp" },
--       --   { name = "path" },
--       --   {
--       --     name = "buffer",
--       --     option = {
--       --       get_bufnrs = function()
--       --         return vim.api.nvim_list_bufs()
--       --       end,
--       --     },
--       --     keyword_length = 5,
--       --   },
--       --   {
--       --     name = "spell",
--       --     keyword_length = 5,
--       --     option = {
--       --       keep_all_entries = true,
--       --     },
--       --   },
--       -- }
--       -- for _, source in pairs(sources) do
--       --   table.insert(opts.sources, 1, source)
--       -- end
--
--       return {
--         preselect = cmp.PreselectMode.None,
--
--         completion = {
--           completeopt = "menu,menuone,noinsert,noselect",
--         },
--
--         mapping = cmp.mapping.preset.insert({
--           ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
--           ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
--           ["<C-b>"] = cmp.mapping.scroll_docs(-1),
--           ["<C-f>"] = cmp.mapping.scroll_docs(1),
--           ["<C-Space>"] = cmp.mapping.complete(),
--           ["<C-e>"] = cmp.mapping.abort(),
--           -- Accept currently selected item.
--           -- Set `select` to `false` to only confirm explicitly selected items.
--           ["<CR>"] = cmp.mapping.confirm({ select = false }),
--           -- Accept currently selected item.
--           -- Set `select` to `false` to only confirm explicitly selected items.
--           ["<S-CR>"] = cmp.mapping.confirm({
--             behavior = cmp.ConfirmBehavior.Replace,
--             select = true,
--           }),
--           ["<C-CR>"] = function(fallback)
--             cmp.abort()
--             fallback()
--           end,
--         }),
--
--         formatting = {
--           format = function(entry, item)
--             if icons[item.kind] then
--               item.kind = " " .. icons[item.kind]
--             end
--             item.menu = ({
--               nvim_lsp = "[LSP]",
--               path = "[PTH]",
--               buffer = "[BUF]",
--               spell = "[SPL]",
--             })[entry.source.name]
--             return item
--           end,
--         },
--
--         sources = cmp.config.sources({
--           { name = "nvim_lsp_signature_help" },
--           { name = "nvim_lsp" },
--           { name = "path" },
--           {
--             name = "buffer",
--             option = {
--               get_bufnrs = function()
--                 return vim.api.nvim_list_bufs()
--               end,
--             },
--             keyword_length = 5,
--           },
--           {
--             name = "spell",
--             keyword_length = 5,
--             option = {
--               keep_all_entries = true,
--             },
--           },
--         }),
--
--         window = {
--           completion = cmp.config.window.bordered({
--             winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
--           }),
--           documentation = cmp.config.window.bordered({
--             winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
--           }),
--         },
--       }
--     end,
--   },
-- }
