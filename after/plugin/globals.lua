P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

Reload = function()
  local module = vim.fn.input("Module: ", "", "file")
  if module ~= "" then
    R(module)
  end
end

Works = function(item)
  local maybe = require("bw.util.specification")

  local warn = function(msg)
    vim.notify(msg, vim.log.levels.WARN, { title = "Globals" })
  end

  local is_string = function(x)
    if require("bw.util.guard").is_string(x) then
      return maybe.just(x)
    end
    warn("not a string")
    return maybe.nothing()
  end

  local is_directory = function(x)
    return maybe.unit(x):bind(is_string):bind(function()
      if require("bw.util.fs").is_directory(x) then
        return maybe.just(x)
      end
      warn("Not a directory")
      return maybe.nothing()
    end)
  end

  local result = maybe.unit(item):bind(is_directory)

  if result.is_just then
    vim.notify("is a directory")
  end
end

-- local function is_string(input)
--   local input_type = type(input)
--   if input_type == "string" then
--     return maybe.just(input)
--   end
--   local format_string = "expected string but got %s with value %s"
--   vim.notify(string.format(format_string, input_type, input))
--   return maybe.nothing()
-- end
--
-- local function is_directory(input)
--   if require("bw.util.fs").is_directory(input) then
--     return maybe.just(input)
--   end
--   vim.notify(string.format("not a directory: %s", input))
--   return maybe.nothing()
-- end
--
-- local function can_git_ls(input)
--   local command = string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand(input))
--   vim.fn.system(command)
--
--   if vim.v.shell_error == 0 then
--     return maybe.just(require("telescope.builtin").git_files({ cwd = input }))
--   else
--     vim.notify(string.format("%s is not a git repository.", input))
--     return maybe.nothing()
--   end
-- end
--

------comment
------@param x any
------@param validator GitCommandValidator
------@return Maybe
---local function validate(x, validator)
---  if validator.tester(x) then
---    validator.doer(x)
---    return maybe.nothing()
---  end
---  return maybe.just(x)
---end

-- Example usage
-- local _ = maybe
--   .unit(item)
--   :bind(function(x)
--     return is_string(x)
--   end)
--   :bind(function(x)
--     return is_directory(x)
--   end)
--   :bind(function(x)
--     return can_git_ls(x)
--   end)

-- if result.is_just then
--   require("telescope.builtin").git_files({ cwd = result.value })
-- end

-- local function build_validator(x, validators)
--   local validator = maybe.unit(x)
--   for _, v in ipairs(validators) do
--     local f = function(x)
--       if v.tester(x) then
--         validator.doer(x)
--         return maybe:nothing()
--       end
--       return maybe:just(x)
--     end
--     validator.bind(f)
--   end
-- end

-- build_validator(item, s)

Test = function(item)
  local maybe = require("bw.util.specification")

  ---@class Spec
  ---@field condition function
  ---@field msg string

  ---@type Spec[]
  local specs = {
    is_string = {
      condition = function(opts)
        return type(opts) == "string"
      end,
      msg = "Not a string",
    },

    is_directory = {
      condition = function(opts)
        return require("bw.util.fs").is_directory(opts)
      end,
      msg = "Not a directory",
    },

    is_git_directory = {
      condition = function(opts)
        local format_string = "git -C %s rev-parse --show-toplevel"
        local command = string.format(format_string, vim.fn.expand(opts))
        vim.fn.system(command)
        return vim.v.shell_error == 0
      end,
      msg = "Not a git directory",
    },
  }

  ---@param spec Spec
  ---@return function
  local function create_maybe_check(spec)
    return function(x)
      if spec.condition(x) then
        return maybe.just(x)
      else
        vim.notify(spec.msg)
        return maybe.nothing()
      end
    end
  end

  local function wrap(inner, outer)
    return inner:bind(function(value)
      return create_maybe_check(outer)(value)
    end)
  end

  local is_string = create_maybe_check(specs.is_string)

  local function is_directory(opts)
    return wrap(is_string(opts), specs.is_directory)
  end

  local function is_git_directory(opts)
    return wrap(is_directory(opts), specs.is_git_directory)
  end

  local result = is_git_directory(item)

  if result.is_just then
    vim.notify(string.format("%s is a git directory", result.value))
  end
end
