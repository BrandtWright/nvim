---@class Either
---@field is_right boolean Whether this is a Right (success) value
---@field value? any The success value (only present when is_right = true)
---@field error? any The error value (only present when is_right = false)
local Either = {}
Either.__index = Either

-- Type constructor for right
function Either.right(value)
  return setmetatable({ value = value, is_right = true }, Either)
end

-- Type constructor for left
function Either.left(error)
  return setmetatable({ error = error, is_right = false }, Either)
end

-- Lifts a value into a monadic context
function Either.unit(value)
  return Either.right(value)
end

-- Applies a function to a monadic value
function Either:bind(func)
  if self.is_right then
    return func(self.value)
  else
    return self
  end
end

-- Utility function to handler errors
function Either:handle_error(handler)
  if not self.is_right then
    return handler(self.error)
  else
    return self
  end
end

return Either
