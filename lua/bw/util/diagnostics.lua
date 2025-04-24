M = {}

local default_opts = {
  float = {
    show_header = true,
    border = "single",
  },
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
}

M.get_default_opts = function()
  return default_opts
end

return M
