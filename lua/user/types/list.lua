---@class List
---@field value table
local List = {}
List.__index = List

-- Type constructor for List
function List.new(value)
  return setmetatable({ value = value }, List)
end

-- Monad unit function: lifts a value into the monadic context
function List.unit(value)
  return List.new({ value })
end

-- Bind function: applies a function to each element in the list and flattens the result
function List:bind(func)
  local result = {}
  for _, v in ipairs(self.value) do
    local mapped = func(v)
    for _, mv in ipairs(mapped.value) do
      table.insert(result, mv)
    end
  end
  return List.new(result)
end

-- Utility function to create a list from a table
function List.from_table(tbl)
  return List.new(tbl)
end

-- Utility function to convert a list back to a table
function List:to_table()
  return self.value
end

return List
