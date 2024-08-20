---@class Maybe
---@field is_just boolean
---@field value any
local Maybe = {}
Maybe.__index = Maybe

-- Type constructor for Just
function Maybe.just(value)
  return setmetatable({ value = value, is_just = true }, Maybe)
end

-- Type constructor for Nothing
function Maybe.nothing()
  return setmetatable({ is_just = false }, Maybe)
end

-- Lifts a value into a monadic context
function Maybe.unit(value)
  return Maybe.just(value)
end

-- Applies a function to a monadic value
function Maybe:bind(func)
  if self.is_just then
    return func(self.value)
  else
    return Maybe.nothing()
  end
end

return Maybe
