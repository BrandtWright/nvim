local M = {}

--- Prompts for a value and runs `fn` with it, but only when the user entered a
--- non-empty value -- an empty or cancelled prompt is a no-op. Centralizes the
--- "ask, then pick" guard shared by the directory/type picker keymaps so the
--- empty-input check lives in one place.
---@param prompt string Prompt label shown to the user
---@param completion string? A `:h command-completion` type (e.g. "dir"), or nil for none
---@param fn fun(value: string) Receives the entered value
function M.with_input(prompt, completion, fn)
  local value = completion and vim.fn.input(prompt, "", completion) or vim.fn.input(prompt)
  if value and value ~= "" then
    fn(value)
  end
end

return M
