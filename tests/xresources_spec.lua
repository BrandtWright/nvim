local xr = require("spf.xresources")

describe("spf.xresources.parse", function()
  it("parses key:value lines into a table", function()
    local t = xr.parse("URxvt.foreground: #ffffff\nURxvt.background:\t#000000")
    assert.equals("#ffffff", t["URxvt.foreground"])
    assert.equals("#000000", t["URxvt.background"])
  end)

  it("also stores wildcard '*.' entries under the stripped key", function()
    local t = xr.parse("*.color0: #1c1c1c")
    assert.equals("#1c1c1c", t["*.color0"]) -- original preserved
    assert.equals("#1c1c1c", t["color0"]) -- stripped alias
  end)

  it("also stores bare '*' wildcard entries under the stripped key", function()
    local t = xr.parse("*color0: #1c1c1c")
    assert.equals("#1c1c1c", t["*color0"]) -- original preserved
    assert.equals("#1c1c1c", t["color0"]) -- stripped alias
  end)

  it("does not strip non-wildcard keys", function()
    local t = xr.parse("screen_glasses.ui.cursor_line: #1c1c1c")
    assert.equals("#1c1c1c", t["screen_glasses.ui.cursor_line"])
    assert.is_nil(t["cursor_line"]) -- no spurious stripped alias
  end)

  it("skips malformed/blank lines", function()
    local t = xr.parse("good.key: #abcdef\nnonsense without colon\n\n")
    assert.equals("#abcdef", t["good.key"])
    assert.is_nil(t["nonsense without colon"])
  end)

  it("returns an empty table for empty input", function()
    assert.same({}, xr.parse(""))
  end)
end)

describe("spf.xresources.color", function()
  local t = {
    ok = "#dba270",
    not_hex = "blue",
    short = "#fff",
    too_long = "#1234567",
    bad_digit = "#gggggg",
  }

  it("returns the value for a valid #rrggbb color", function()
    assert.equals("#dba270", xr.color(t, "ok"))
  end)

  it("returns nil for non-hex / malformed / missing values", function()
    assert.is_nil(xr.color(t, "not_hex"))
    assert.is_nil(xr.color(t, "short"))
    assert.is_nil(xr.color(t, "too_long"))
    assert.is_nil(xr.color(t, "bad_digit"))
    assert.is_nil(xr.color(t, "absent_key"))
  end)
end)
