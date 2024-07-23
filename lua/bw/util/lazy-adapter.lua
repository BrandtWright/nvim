local M = {}

-- TODO: Handle dependency build command.

-- TODO: Handle desc/opts better

M.getKeys = function(keys)
  local lazyKeys = {}
  for _, v in pairs(keys) do
    table.insert(lazyKeys, {
      v.lhs,
      v.rhs,
      mode = v.mode,
      desc = v.opts.desc,
    })
  end
  return lazyKeys
end

return M
