---@class List
---@field value table The backing array of elements
local List = {}
List.__index = List

--- Constructs a List from an existing array.
---@param value table
---@return List
function List.new(value)
  return setmetatable({ value = value }, List)
end

--- Lifts a single value into a one-element List.
---@param value any
---@return List
function List.unit(value)
  return List.new({ value })
end

--- Creates a List from a table.
---@param tbl table
---@return List
function List.from_table(tbl)
  return List.new(tbl)
end

--- Maps a plain function over each element.
---@param func fun(value: any): any
---@return List
function List:map(func)
  local result = {}
  for _, v in ipairs(self.value) do
    table.insert(result, func(v))
  end
  return List.new(result)
end

--- Applies func (which must return a List) to each element and flattens the
--- results. A func result that is not a List (no `.value` array) contributes
--- nothing rather than erroring.
---@param func fun(value: any): List
---@return List
function List:bind(func)
  local result = {}
  for _, v in ipairs(self.value) do
    local mapped = func(v)
    local inner = type(mapped) == "table" and type(mapped.value) == "table" and mapped.value or {}
    for _, mv in ipairs(inner) do
      table.insert(result, mv)
    end
  end
  return List.new(result)
end

--- Converts a List back to a plain table.
---@return table
function List:to_table()
  return self.value
end

return List
