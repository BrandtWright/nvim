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

Test = function(item)
  local maybe = require("bw.util.specification")

  local function is_string(input)
    local input_type = type(input)
    if input_type == "string" then
      return maybe.just(input)
    end
    local format_string = "expected string but got %s with value %s"
    vim.notify(string.format(format_string, input_type, input))
    return maybe.nothing()
  end

  local function is_directory(input)
    if require("bw.util.fs").is_directory(input) then
      return maybe.just(input)
    end
    vim.notify(string.format("not a directory: %s", input))
    return maybe.nothing()
  end

  local function can_git_ls(input)
    local command = string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand(input))
    vim.fn.system(command)

    if vim.v.shell_error == 0 then
      return maybe.just(require("telescope.builtin").git_files({ cwd = input }))
    else
      vim.notify(string.format("%s is not a git repository.", input))
      return maybe.nothing()
    end
  end

  ---@class GitCommandValidator
  ---@field tester boolean
  ---@field doer function

  local s = {
    {
      tester = not require("bw.util.guard").is_string,
      doer = function(x)
        local msg = string.format("expected string but got %s with value %s", type(x), x)
        vim.notify(msg)
      end,
    },
  }

  ---comment
  ---@param x any
  ---@param validators GitCommandValidator[]
  local function build_validator(x, validators)
    local validator = maybe.unit(x)
    for _, v in ipairs(validators) do
      local f = function(x)
        if v.tester(x) then
          validator.doer(x)
          return maybe:nothing()
        end
        return maybe:just(x)
      end
      validator.bind(f)
    end
  end

  build_validator(item, s)

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
end
