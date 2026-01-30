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

local ns = vim.api.nvim_create_namespace("markdown_tasks")

local function find_open_tasks()
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = {}
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    local _, match_end = line:find("^%s*%- %[ %]%s*")

    if match_end then
      local task_text = line:sub(match_end + 1)

      if #task_text > 0 then
        table.insert(diagnostics, {
          lnum = i - 1,
          col = match_end,
          end_lnum = i - 1,
          end_col = #line,
          severity = vim.diagnostic.severity.HINT,
          message = "Task: " .. task_text,
          source = "Markdown",
        })
      end
    end
  end

  vim.diagnostic.set(ns, bufnr, diagnostics)
end

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "TextChanged", "InsertLeave" }, {
  pattern = "*.md",
  callback = find_open_tasks,
})
