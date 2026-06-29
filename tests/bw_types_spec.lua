local Either = require("bw.types.either")
local Maybe = require("bw.types.maybe")
local List = require("bw.types.list")

describe("bw.types.either", function()
  it("map transforms a Right and passes a Left through", function()
    assert.equals(
      4,
      Either.right(2):map(function(x)
        return x * 2
      end).value
    )

    local left = Either.left("boom")
    local mapped = left:map(function(x)
      return x * 2
    end)
    assert.is_false(mapped.is_right)
    assert.equals("boom", mapped.error)
  end)

  it("bind chains Rights and short-circuits on Left", function()
    local half = function(x)
      return x % 2 == 0 and Either.right(x / 2) or Either.left("odd")
    end
    assert.equals(2, Either.unit(8):bind(half):bind(half).value)

    local result = Either.unit(5):bind(half):bind(half)
    assert.is_false(result.is_right)
    assert.equals("odd", result.error)
  end)

  it("handle_error recovers a Left and ignores a Right", function()
    assert.equals(
      "recovered",
      Either.left("e"):handle_error(function()
        return "recovered"
      end)
    )
    -- On a Right, handler is not called and the Either is returned unchanged.
    local right = Either.right(1)
    assert.equals(
      right,
      right:handle_error(function()
        return "nope"
      end)
    )
  end)
end)

describe("bw.types.maybe", function()
  it("map transforms a Just and passes Nothing through", function()
    assert.equals(
      10,
      Maybe.just(5):map(function(x)
        return x * 2
      end).value
    )
    assert.is_false(Maybe.nothing():map(function(x)
      return x * 2
    end).is_just)
  end)

  it("from_nilable distinguishes nil from present values", function()
    assert.is_false(Maybe.from_nilable(nil).is_just)
    assert.equals(0, Maybe.from_nilable(0).value)
  end)

  it("bind chains and get_or_else unwraps with a default", function()
    local result = Maybe.unit(3):bind(function(x)
      return Maybe.just(x + 1)
    end)
    assert.equals(4, result.value)
    assert.equals(4, result:get_or_else(99))
    assert.equals(99, Maybe.nothing():get_or_else(99))
  end)
end)

describe("bw.types.list", function()
  it("map applies a function to each element", function()
    assert.same(
      { 2, 4, 6 },
      List.from_table({ 1, 2, 3 })
        :map(function(x)
          return x * 2
        end)
        :to_table()
    )
  end)

  it("unit wraps a single value", function()
    assert.same({ 7 }, List.unit(7):to_table())
  end)

  it("bind flattens List-returning functions", function()
    local dup = function(x)
      return List.new({ x, x })
    end
    assert.same({ 1, 1, 2, 2 }, List.from_table({ 1, 2 }):bind(dup):to_table())
  end)

  it("bind ignores non-List results instead of erroring", function()
    local bad = function()
      return nil
    end
    assert.same({}, List.from_table({ 1, 2 }):bind(bad):to_table())
  end)
end)
