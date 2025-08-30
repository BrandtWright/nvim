# TODO - Neovim Configuration

## Code Review Summary

**Project Assessment**: Excellent (9.5/10)  
**Files Analyzed**: 58 Lua files  
**Linting Issues**: 0 warnings, 0 errors  
**Architecture**: Well-structured, modular design  

---

## High Priority Issues

### 1. Fix Typo in Window Movement Description

**File**: `lua/config/keymaps.lua:51`  
**Issue**: Typo in keymap description  
**Current**:

```lua
desc = "Move Window Doen"
```

**Fix**:

```lua
desc = "Move Window Down"
```

**Priority**: High (affects user experience)  
**Estimated Time**: 1 minute

### 2. Fix Missing Return Statements in Slipbox Validation

**File**: `lua/user/slipbox/init.lua:139-147`  
**Issue**: Validation checks don't prevent function execution  
**Current**:

```lua
if not slip_id then
  vim.notify( "Invalid argument: slip_id is nil", vim.log.levels.ERROR, { title
    = "Slipbox" })
end
if slip_id == "" then
  vim.notify("Invalid argument: slip_id is empty", vim.log.levels.ERROR, {
    title = "Slipbox" })
end
if type(slip_id) ~= "string" then
  vim.notify("Invalid argument: slip_id expected to be a string",
    vim.log.levels.ERROR, { title = "Slipbox" })
end
```

**Fix**:

```lua
if not slip_id then
  vim.notify("Invalid argument: slip_id is nil", vim.log.levels.ERROR, { title
    = "Slipbox" })
  return
end
if slip_id == "" then
  vim.notify("Invalid argument: slip_id is empty", vim.log.levels.ERROR, {
    title = "Slipbox" })
  return
end
if type(slip_id) ~= "string" then
  vim.notify("Invalid argument: slip_id expected to be a string",
    vim.log.levels.ERROR, { title = "Slipbox" })
  return
end
```

**Priority**: High (logic bug)  
**Estimated Time**: 2 minutes

---

## Medium Priority Improvements

### 3. Add Graceful Degradation for External Dependencies

**Files**: `lua/config/keymaps.lua:270`, `lua/user/slipbox/init.lua`  
**Issue**: Hardcoded external commands may fail if tools aren't installed  
**Current Issues**:

- `dict` command usage without checking availability
- `snote` command dependency not validated
- `xrdb` command used without fallback

**Recommended Solution**:

```lua
-- Create utility function in lua/bw/util/external.lua
local M = {}

M.check_command = function(cmd)
  return vim.fn.executable(cmd) == 1
end

M.safe_dict_lookup = function(word)
  if M.check_command("dict") then
    vim.cmd("!dict " .. word)
  else
    vim.notify("Dictionary command 'dict' not found. Please install it.", vim.log.levels.WARN)
  end
end

return M
```

**Priority**: Medium (robustness)  
**Estimated Time**: 30 minutes

### 4. Extract Hardcoded Paths to Configuration

**Files**: `lua/config/keymaps.lua:132-134`, `lua/user/slipbox/init.lua`  
**Issue**: Hardcoded paths reduce portability  
**Current**:

```lua
map("n", "<leader>osh", "<cmd>edit ~/data/projects/scratch/README.md<cr>", {
  desc = "Current Window" })
```

**Recommended Solution**:

```lua
-- Add to lua/config/options.lua or create lua/config/paths.lua
vim.g.scratch_file = vim.fn.expand("~/data/projects/scratch/README.md")

-- Update keymaps
map("n", "<leader>osh", "<cmd>edit " .. vim.g.scratch_file .. "<cr>", { desc =
  "Current Window" })
```

**Priority**: Medium (maintainability)  
**Estimated Time**: 15 minutes

### 5. Add Configuration Validation on Startup

**File**: New file `lua/config/validate.lua`  
**Issue**: No validation of required directories/tools  
**Recommended Implementation**:

```lua
local M = {}

M.validate_setup = function()
  local issues = {}
  
  -- Check scratch directory
  local scratch_dir = vim.fn.expand("~/data/projects/scratch")
  if not vim.uv.fs_stat(scratch_dir) then
    table.insert(issues, "Scratch directory not found: " .. scratch_dir)
  end
  
  -- Check external tools
  local tools = { "snote", "dict", "xrdb" }
  for _, tool in ipairs(tools) do
    if vim.fn.executable(tool) == 0 then
      table.insert(issues, "Optional tool not found: " .. tool)
    end
  end
  
  if #issues > 0 then
    vim.notify(table.concat(issues, "\n"), vim.log.levels.WARN, { title =
      "Config Issues" })
  end
end

return M
```

**Priority**: Medium (user experience)  
**Estimated Time**: 45 minutes

---

## Low Priority Enhancements

### 6. Add Project Documentation

**Files**: Create `README.md`, `FEATURES.md`  
**Issue**: Missing documentation for custom features  
**Recommended Content**:

- Installation instructions
- Custom picker overview
- Slipbox system documentation
- Keybinding reference
- Colorscheme customization guide

**Priority**: Low (documentation)  
**Estimated Time**: 2 hours

### 7. Modernize Deprecated Functions

**Files**: Various  
**Issue**: Some vim.fn calls could be modernized  
**Examples to Consider**:

```lua
-- Current
vim.fn.expand('%:t')
-- Consider: vim.fs.basename(vim.api.nvim_buf_get_name(0))

-- Current  
vim.fn.system()
-- Consider: vim.system() where appropriate
```

**Priority**: Low (modernization)  
**Estimated Time**: 1 hour

### 8. Add Unit Tests for Custom Utilities

**Files**: Create `tests/` directory  
**Issue**: No test coverage for custom modules  
**Recommended Approach**:

- Use `busted` or `luassert` framework
- Focus on testing `bw/util/*` and `user/slipbox/*` modules
- Add CI workflow for testing

**Priority**: Low (testing)  
**Estimated Time**: 4+ hours

### 9. Enhance Error Messages with Context

**Files**: `lua/bw/util/xresources.lua`, `lua/user/slipbox/init.lua`  
**Issue**: Some error messages could be more helpful  
**Current**:

```lua
vim.notify("Failed to save file: " .. result.stderr, vim.log.levels.ERROR)
```

**Enhanced**:

```lua
vim.notify(
  string.format("Failed to save slip '%s': %s\nTry: snote --help", slip_id,
    result.stderr), 
  vim.log.levels.ERROR, 
  { title = "Slipbox" }
)
```

**Priority**: Low (user experience)  
**Estimated Time**: 30 minutes

---

## Future Considerations

### 10. Performance Monitoring

- Add startup time measurement
- Monitor picker performance with large file counts
- Profile memory usage of custom modules

### 11. Plugin Update Management  

- Add notification system for plugin updates
- Create changelog viewer for LazyVim updates
- Implement plugin rollback functionality

### 12. Advanced Colorscheme Features

- Add support for multiple colorscheme variants
- Implement time-based theme switching
- Add colorscheme preview functionality

---

## Implementation Plan

### Week 1: Critical Fixes

- [ ] Fix typo in keymaps.lua (Item #1)
- [ ] Fix slipbox validation returns (Item #2)
- [ ] Add external command validation (Item #3)

### Week 2: Configuration Improvements  

- [ ] Extract hardcoded paths (Item #4)
- [ ] Add startup validation (Item #5)
- [ ] Enhance error messages (Item #9)

### Week 3: Documentation

- [ ] Create comprehensive README (Item #6)
- [ ] Document custom features
- [ ] Add inline code comments where needed

### Future Sprints

- [ ] Function modernization (Item #7)
- [ ] Unit testing framework (Item #8)
- [ ] Performance monitoring (Item #10)

---

## Notes

- All current code passes luacheck with zero issues ✅
- Architecture is excellent and requires no major restructuring ✅  
- Focus should be on polish and documentation rather than major changes ✅
- Consider creating feature branches for larger improvements ✅
