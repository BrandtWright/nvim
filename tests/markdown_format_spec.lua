-- Markdown formatting is markdownlint-cli2 driven by .markdownlint-cli2.yaml,
-- not prettier (whose markdown style is fixed and unconfigurable). A regression
-- here means saves could start rewriting markdown in prettier's style again.

-- Typed as a plain table: lua_ls infers the spec list's element type from all
-- entries, and render-markdown's `opts` is a function, hiding conform's fields.
---@return table
local function conform_spec()
  for _, spec in ipairs(require("plugins.lang.markdown")) do
    if spec[1] == "stevearc/conform.nvim" then
      return spec
    end
  end
  error("no conform.nvim spec in plugins.lang.markdown")
end

describe("markdown formatting", function()
  it("formats markdown and mdx without prettier", function()
    local by_ft = conform_spec().opts.formatters_by_ft
    for _, ft in ipairs({ "markdown", "markdown.mdx" }) do
      assert.same({ "markdownlint-cli2", "markdown-toc" }, by_ft[ft])
    end
  end)

  it("always runs markdownlint-cli2, not only when diagnostics exist", function()
    local condition = conform_spec().opts.formatters["markdownlint-cli2"].condition
    assert.is_true(condition())
  end)
end)
