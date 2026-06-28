---@class Maybe
---@field is_just boolean Whether a value is present
---@field value? any The contained value (only present when is_just = true)
local Maybe = {}
Maybe.__index = Maybe

--- Constructs a Just (a present value).
---@param value any
---@return Maybe
function Maybe.just(value)
  return setmetatable({ value = value, is_just = true }, Maybe)
end

--- Constructs a Nothing (an absent value).
---@return Maybe
function Maybe.nothing()
  return setmetatable({ is_just = false }, Maybe)
end

--- Lifts a value into a Just.
---@param value any
---@return Maybe
function Maybe.unit(value)
  return Maybe.just(value)
end

--- Just(value) unless value is nil, in which case Nothing. Useful for wrapping
--- the result of a lookup that may return nil.
---@param value any
---@return Maybe
function Maybe.from_nilable(value)
  if value == nil then
    return Maybe.nothing()
  end
  return Maybe.just(value)
end

--- Maps a plain function over the contained value. Nothing passes through.
--- A func that returns nil yields Nothing (via from_nilable) rather than a
--- Just wrapping nil, which would violate the type's invariant.
---@param func fun(value: any): any
---@return Maybe
function Maybe:map(func)
  if self.is_just then
    return Maybe.from_nilable(func(self.value))
  end
  return self
end

--- Chains a function that itself returns a Maybe. Nothing passes through.
---@param func fun(value: any): Maybe
---@return Maybe
function Maybe:bind(func)
  if self.is_just then
    return func(self.value)
  else
    return Maybe.nothing()
  end
end

--- Returns the contained value if Just, otherwise the supplied default.
---@param default any
---@return any
function Maybe:get_or_else(default)
  if self.is_just then
    return self.value
  end
  return default
end

return Maybe
