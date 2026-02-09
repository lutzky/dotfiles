local autocmd_group = vim.api.nvim_create_augroup("Projects", { clear = true })

local function open_project_dashboard()
  local output = vim.fn.systemlist("projects")

  table.insert(output, 1, " 💡  [/] Search (\\c) | [gf] Open | [,pr] Refresh | [q]uit")

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)

  vim.bo[buf].filetype = "markdown"
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = false
  vim.bo[buf].readonly = true

  vim.wo.number = true

  vim.api.nvim_command("buffer " .. buf)

  local map_opts = { noremap = true, silent = true, buffer = buf }

  vim.keymap.set('n', 'q', ':bwipeout!<CR>', map_opts)
  vim.keymap.set('n', '/', '/\\c', { noremap = true, buffer = buf })

  -- Custom 'gf' logic to handle spaces, avoiding setting isfname and
  -- suffixesadd, especially because isfname is global.
  vim.keymap.set('n', 'gf', function()
    local line = vim.api.nvim_get_current_line()

    local project_name = line:match("%[%[(.-)%]%]")

    if project_name then
      local target = project_name .. ".md"

      if vim.fn.filereadable(target) == 1 then
        -- Loading this way instead of `vim.cmd("edit")` ensures that various
        -- autocmds load correctly.
        local bufnr = vim.fn.bufadd(target)
        vim.fn.bufload(bufnr)
        vim.api.nvim_set_current_buf(bufnr)
        vim.bo[bufnr].filetype = "markdown"
        vim.cmd("normal! zz")
      else
        print("File not found: " .. target)
      end
    else
      print("Could not parse project path from line.")
    end
  end, map_opts)

  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = buf,
    group = autocmd_group,
    once = true,
    callback = function()
      -- Use vim.schedule to avoid skipping the .template BufNewFile autocmd
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end)
    end
  })
end

vim.api.nvim_create_user_command('Projects', open_project_dashboard, {})
vim.keymap.set('n', '<Leader>pr', ':Projects<CR>', { silent = true })

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
  group = autocmd_group,
  pattern = "*.md",
  callback = find_open_tasks,
})

vim.api.nvim_create_user_command('ProjectInboxNote', function()
  -- Match silverbullet.md's naming
  local folder_path = vim.fn.expand("./Inbox/") .. os.date("%Y-%m-%d")
  local file_name = os.date("%H-%M-%S") .. ".md"
  local full_path = folder_path .. "/" .. file_name

  vim.fn.mkdir(folder_path, "p")

  vim.cmd("edit " .. vim.fn.fnameescape(full_path))
end, {})

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.md",
  group = autocmd_group,
  callback = function()
    local template_path = vim.fn.expand("%:p:h") .. "/.template"

    if vim.fn.filereadable(template_path) == 1 then
      vim.cmd("0read " .. template_path)
      -- Place the cursor at the end of the file
      vim.cmd("normal! G")
    end
  end,
})
