local function open_project_dashboard()
  local buf = vim.api.nvim_create_buf(false, true)

  local options = {
    bufhidden = "wipe",
    buftype = "nofile",
    filetype = "markdown",
    swapfile = false,
  }
  for k, v in pairs(options) do vim.api.nvim_buf_set_option(buf, k, v) end

  local output = vim.fn.systemlist("projects")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
  vim.api.nvim_command("buffer " .. buf)

  vim.api.nvim_buf_set_option(buf, "modifiable", false)

  -- When you leave this buffer (e.g., by following a link), it wipes itself.
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = buf,
    once = true,
    callback = function()
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  })
end

vim.api.nvim_create_user_command('Projects', open_project_dashboard, {})

vim.api.nvim_create_user_command('ProjectHeader', function()
  local today = os.date("%Y-%m-%d")
  local preamble = {
    "---",
    "priority: P2",
    "status: Active",
    "# snooze_until:",
    "---",
    "",
    "# " .. today,
  }

  -- Insert at the very top of the buffer (index 0 to 0)
  vim.api.nvim_buf_set_lines(0, 0, 0, false, preamble)

  -- Move cursor to the end of the last line of the preamble to type the title
  -- {line_number, column} - the preamble is 7 lines
  vim.api.nvim_win_set_cursor(0, { 8, 1 })

  -- Switch to insert mode automatically
  vim.cmd("startinsert!")
end, {})
