---@class Either
---@field is_right boolean
---@field value any
---@field error any
local Either = {}
Either.__index = Either

function Either.right(value)
  return setmetatable({ value = value, is_right = true }, Either)
end

function Either.left(error)
  return setmetatable({ error = error, is_right = false }, Either)
end

function Either.unit(value)
  return Either.right(value)
end

function Either:bind(func)
  if self.is_right then
    return func(self.value)
  else
    return self
  end
end

function Either:handle_error(handler)
  if not self.is_right then
    return handler(self.error)
  else
    return self
  end
end

return Either
