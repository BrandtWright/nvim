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
    vim.notify(string.format("expected string but got %s", input_type))
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
      return maybe.just(input)
    else
      vim.notify(string.format("%s is not a git repository.", input))
      return maybe.nothing()
    end
  end

  -- Example usage
  local result = maybe
    .unit(item)
    :bind(function(x)
      return is_string(x)
    end)
    :bind(function(x)
      return is_directory(x)
    end)
    :bind(function(x)
      return can_git_ls(x)
    end)

  if result.is_just then
    require("telescope.builtin").git_files({ cwd = result.value })
  end
end
