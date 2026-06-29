-- bw.util.scratch-buffer: the transient scratch buffer is created/reused via a
-- buffer-local identity tag and shown in several display modes. These drive real
-- windows in the headless harness. Only the behaviours with actual logic are
-- covered: the reuse dedup, the popup `relative ~= ""` float guard, and the
-- 'q'-map lifetime cleanup -- the bits the source comments call out as subtle.

local scratch = require("bw.util.scratch-buffer")

local function scratch_bufs()
  local found = {}
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.b[b].bw_scratch then
      table.insert(found, b)
    end
  end
  return found
end

local function floats_for(buf)
  local n = 0
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(w) == buf and vim.api.nvim_win_get_config(w).relative ~= "" then
      n = n + 1
    end
  end
  return n
end

local function buf_has_keymap(buf, lhs)
  for _, m in ipairs(vim.api.nvim_buf_get_keymap(buf, "n")) do
    if m.lhs == lhs then
      return true
    end
  end
  return false
end

describe("bw.util.scratch-buffer.open_scratch_buffer", function()
  after_each(function()
    -- reset to a single normal window so modes don't accumulate splits/floats
    vim.cmd("silent! only")
    vim.cmd("enew")
  end)

  it("reuses a single buffer across calls", function()
    scratch.open_scratch_buffer("current_window")
    scratch.open_scratch_buffer("current_window")
    assert.equals(1, #scratch_bufs())
  end)

  it("popup focuses an existing float instead of duplicating it", function()
    scratch.open_scratch_buffer("popup")
    local buf = scratch_bufs()[1]
    assert.equals(1, floats_for(buf))
    scratch.open_scratch_buffer("popup")
    assert.equals(1, floats_for(buf)) -- focused the existing float, did not open a second
  end)

  it("removes the popup 'q' map when the float closes", function()
    scratch.open_scratch_buffer("popup")
    local buf = scratch_bufs()[1]
    assert.is_true(buf_has_keymap(buf, "q"))

    -- close the float; the WinClosed autocmd should drop the buffer-local 'q'
    for _, w in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(w) == buf and vim.api.nvim_win_get_config(w).relative ~= "" then
        vim.api.nvim_win_close(w, true)
      end
    end
    assert.is_false(buf_has_keymap(buf, "q"))
  end)
end)
