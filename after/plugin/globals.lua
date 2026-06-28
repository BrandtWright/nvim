-- Interactive dev helpers, exposed as globals for use at the `:lua` prompt
-- (e.g. `:lua P(x)`, `:lua R("some.module")`). Defined with the explicit `_G.`
-- prefix to signal these are intentional globals.

--- Pretty-print a value and return it (handy for inline inspection).
_G.P = function(v)
  print(vim.inspect(v))
  return v
end

--- Unload a Lua module so the next require re-reads it from disk.
_G.RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

--- Reload and re-require a module, returning the fresh copy.
_G.R = function(name)
  RELOAD(name)
  return require(name)
end

--- Prompt for a module name and reload it.
_G.Reload = function()
  local module = vim.fn.input("Module: ", "", "file")
  if module ~= "" then
    R(module)
  end
end
