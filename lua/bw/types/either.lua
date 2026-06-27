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

--- Maps a plain function over the Right value, re-wrapping the result.
--- A Left passes through unchanged.
---@param func fun(value: any): any
---@return Either
function Either:map(func)
  if self.is_right then
    return Either.right(func(self.value))
  end
  return self
end

--- Chains a function that itself returns an Either. A Left passes through.
---@param func fun(value: any): Either
---@return Either
function Either:bind(func)
  if self.is_right then
    return func(self.value)
  else
    return self
  end
end

--- Recovers from a Left by calling handler(error) and returning its result.
--- On a Right the handler is not called and the Either is returned unchanged,
--- so this is a terminal operation rather than a chainable one.
---@param handler fun(error: any): any
---@return any|Either
function Either:handle_error(handler)
  if not self.is_right then
    return handler(self.error)
  else
    return self
  end
end

return Either
