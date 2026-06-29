exclude_files = {
  ".tests-deps", -- vendored test deps (plenary); not our code
  -- Local Lua / LuaRocks install trees. In CI, leafo/gh-actions-lua and
  -- gh-actions-luarocks drop these inside the workspace, so `luacheck .` would
  -- otherwise lint luacheck's own (non-clean) source and fail. Not our code.
  ".lua",
  ".luarocks",
}
ignore = {
  "631", -- max_line_length
}
globals = {
  "vim",
  "describe",
  "it",
  "P",
  "RELOAD",
  "R",
  "Reload",
  "Snacks",
  "LazyVim",
}
files["tests"] = {
  ignore = {
    "121", -- Setting a read-only global variable.
    "122", -- Setting a read-only field of a global variable.
  },
}
