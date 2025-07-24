local M = {}

function M.setup(opts)
  -- New Slip
  vim.api.nvim_create_user_command("SlipNew", function()
    local slip_id = vim.fn.trim(vim.fn.system({ "snote", "-n" }))
    vim.cmd("enew")
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(bufnr, "service://slipbox/" .. slip_id)
    vim.api.nvim_set_option_value("buftype", "", { buf = bufnr })
    vim.api.nvim_set_option_value("swapfile", false, { buf = bufnr })
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bufnr })
    vim.api.nvim_set_option_value("filetype", "markdown", { buf = bufnr })
  end, {
    nargs = 0,
    desc = "Create a new slip",
  })

  -- Edit Slip
  vim.api.nvim_create_user_command("SlipEdit", function(args)
    local slip_id = args.args
    vim.cmd("edit " .. opts.slipbox_dir .. "/" .. slip_id .. "/README.md")
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(bufnr, "service://slipbox/" .. slip_id)
    vim.api.nvim_set_option_value("buftype", "", { buf = bufnr })
    vim.api.nvim_set_option_value("swapfile", false, { buf = bufnr })
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bufnr })
    vim.api.nvim_set_option_value("filetype", "markdown", { buf = bufnr })
  end, {
    nargs = 1,
    desc = "Edit slip with ID",
  })

  -- Save Slip
  local group = vim.api.nvim_create_augroup("SlipWrite", { clear = true })
  vim.api.nvim_create_autocmd("BufWriteCmd", {
    group = group,
    pattern = "service://slipbox/*",
    callback = function(args)
      local bufnr = args.buf
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local slip_id = bufname:match("^service://slipbox/(.+)$")
      if slip_id then
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local content = table.concat(lines, "\n")
        local result = vim
          .system({ "snote", "-s", slip_id }, {
            stdin = content,
          })
          :wait()
        if vim.v.shell_error ~= 0 then
          vim.notify("Failed to save file: " .. result, vim.log.levels.ERROR)
        end
        vim.api.nvim_set_option_value("modified", false, { buf = bufnr })
      else
        vim.notify("Invalid slipbox service name", vim.log.levels.ERROR)
      end
    end,
  })
end

return M
