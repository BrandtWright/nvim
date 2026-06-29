-- Tripwire: no two declarative plugin specs bind the same key to different
-- actions.
--
-- A collision is the one keymap bug that does NOT announce itself when you
-- press the key -- lazy.nvim merges every `keys` fragment and the last one
-- registered silently wins, so the other mapping just quietly does nothing.
-- This walks the spec TABLES returned by lua/plugins/**/*.lua (no plugin code
-- runs; we only read `keys`) and fails if any (mode, lhs, ft) has more than one
-- *real* binding.
--
-- SCOPE / what this deliberately does NOT cover:
--   * The direct vim.keymap.set() calls in lua/config/keymaps.lua -- those are
--     runtime, not declarative, so they aren't visible to a static walk.
--   * Collisions against LazyVim's own defaults -- seeing those would mean
--     booting LazyVim, which would forfeit the suite's hermetic, plugin-free
--     CI. The config manages those by hand via `{ lhs, false }` disables.
-- So this is a tripwire for accidental dupes *within this config's own specs*,
-- not a complete keymap audit.
--
-- A `{ lhs, false }` entry DISABLES a key (e.g. shedding a LazyVim default
-- before rebinding it); it removes rather than adds, so it never counts toward
-- a collision. `<leader>ff` in pickers/files.lua is exactly this pattern: a
-- false-disable on LazyVim/LazyVim plus a real binding on snacks.

local this = debug.getinfo(1, "S").source:sub(2)
local root = vim.fn.fnamemodify(this, ":p:h:h")

--- Flattens a spec-file return value into a list of individual spec fragments.
--- A fragment is recognised by a string plugin name at index 1; anything else
--- is treated as a list of specs and recursed into (lazy allows either shape).
---@param spec any value returned by a plugin spec file
---@param out table[] accumulator of spec fragments
local function collect_specs(spec, out)
  if type(spec) ~= "table" then
    return
  end
  if type(spec[1]) == "string" then
    out[#out + 1] = spec
    return
  end
  for _, v in ipairs(spec) do
    collect_specs(v, out)
  end
end

--- Indexes every `keys` entry in `specs` into `acc`, keyed by mode|lhs|ft, with
--- one list of { src, disable } per key. Pure (no IO): caller supplies the
--- already-loaded specs and a source label, so it is unit-testable.
---@param specs table[] spec fragments
---@param src string label identifying where these specs came from (for messages)
---@param acc table<string, { src: string, disable: boolean }[]>
local function index_keys(specs, src, acc)
  for _, s in ipairs(specs) do
    if type(s.keys) == "table" then
      for _, k in ipairs(s.keys) do
        if type(k) == "table" and type(k[1]) == "string" then
          local modes = k.mode or "n"
          if type(modes) == "string" then
            modes = { modes }
          end
          local ft = ""
          if k.ft then
            ft = type(k.ft) == "table" and table.concat(k.ft, ",") or tostring(k.ft)
          end
          for _, mode in ipairs(modes) do
            local id = mode .. "|" .. k[1] .. "|" .. ft
            acc[id] = acc[id] or {}
            acc[id][#acc[id] + 1] = { src = src, disable = k[2] == false }
          end
        end
      end
    end
  end
end

--- Reduces the index to a sorted list of human-readable collisions: any key
--- with two or more *real* (non-disable) bindings. Pure.
---@param acc table<string, { src: string, disable: boolean }[]>
---@return string[]
local function collisions(acc)
  local found = {}
  for id, entries in pairs(acc) do
    local sources = {}
    for _, e in ipairs(entries) do
      if not e.disable then
        sources[#sources + 1] = e.src
      end
    end
    if #sources >= 2 then
      table.sort(sources)
      found[#found + 1] = id .. " bound in: " .. table.concat(sources, ", ")
    end
  end
  table.sort(found)
  return found
end

describe("plugin spec keymap collisions", function()
  -- Self-check: prove the detector actually fires. A green real-config result
  -- below is only meaningful if `collisions` would flag a genuine dupe -- guard
  -- against the tripwire silently passing because the logic broke.
  it("collisions() flags two real bindings for the same key", function()
    local acc = {}
    index_keys({
      { "plugin/a", keys = { { "<leader>x", function() end, desc = "A" } } },
      { "plugin/b", keys = { { "<leader>x", "<cmd>B<cr>", desc = "B" } } },
    }, "synthetic", acc)
    assert.equals(1, #collisions(acc))
  end)

  it("collisions() ignores a disable paired with a real binding", function()
    local acc = {}
    index_keys({
      { "plugin/a", keys = { { "<leader>ff", false } } },
      { "plugin/b", keys = { { "<leader>ff", function() end, desc = "Files" } } },
    }, "synthetic", acc)
    assert.same({}, collisions(acc))
  end)

  it("collisions() does not flag the same lhs in different modes", function()
    local acc = {}
    index_keys({
      { "plugin/a", keys = { { "<leader>y", function() end, mode = "n" } } },
      { "plugin/b", keys = { { "<leader>y", function() end, mode = "x" } } },
    }, "synthetic", acc)
    assert.same({}, collisions(acc))
  end)

  -- The real tripwire: walk this config's own plugin specs.
  it("no declarative spec binds the same key twice", function()
    local files = vim.fn.glob(root .. "/lua/plugins/**/*.lua", false, true)
    assert.is_true(#files > 0, "found no plugin spec files to scan")

    local acc = {}
    for _, path in ipairs(files) do
      local ok, ret = pcall(dofile, path)
      assert.is_true(ok, "spec file failed to load: " .. path .. "\n" .. tostring(ret))
      local specs = {}
      collect_specs(ret, specs)
      index_keys(specs, vim.fn.fnamemodify(path, ":t"), acc)
    end

    assert.same({}, collisions(acc))
  end)
end)
