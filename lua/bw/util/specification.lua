-- Define the Maybe type
local maybe = {}
maybe.__index = maybe

-- Type constructor for Just
function maybe.just(value)
  return setmetatable({ value = value, is_just = true }, maybe)
end

-- Type constructor for Nothing
function maybe.nothing()
  return setmetatable({ is_just = false }, maybe)
end

-- Unit function: wraps a value in the Maybe monad
function maybe.unit(value)
  return maybe.just(value)
end

-- Bind function: applies a function to a monadic value
function maybe:bind(func)
  if self.is_just then
    return func(self.value)
  else
    return maybe.nothing()
  end
end

return maybe
