--- Based on https://luazdf.aiq.dk/fn/shellsplit.html
local function shellsplit(s)
  local words = {}
  local field = ""
  local state = "whitespace"

  for i = 1, #s do
    local c = s:sub(i, i)

    if state == "whitespace" then
      if c == "\\" then
        state = "escape_whitespace"
        field = field .. c
      elseif c == "'" then
        state = "single_quote"
        field = field .. c
      elseif c == '"' then
        state = "double_quote"
        field = field .. c
      elseif not c:match("%s") then
        state = "field"
        field = field .. c
      end
    elseif state == "field" then
      if c == "\\" then
        state = "escape_field"
        field = field .. c
      elseif c == "'" then
        state = "single_quote"
        field = field .. c
      elseif c == '"' then
        state = "double_quote"
        field = field .. c
      elseif c:match("%s") then
        table.insert(words, field)
        field = ""
        state = "whitespace"
      else
        field = field .. c
      end
    elseif state == "escape_whitespace" or state == "escape_field" then
      field = field .. c
      state = "field"
    elseif state == "single_quote" then
      field = field .. c
      -- In POSIX shells, single quotes are 100% literal.
      -- Backslashes do NOT escape single quotes inside single quotes.
      if c == "'" then
        state = "field"
      end
    elseif state == "double_quote" then
      field = field .. c
      if c == "\\" then
        state = "escape_double_quote"
      elseif c == '"' then
        state = "field"
      end
    elseif state == "escape_double_quote" then
      field = field .. c
      state = "double_quote"
    end
  end

  if state ~= "whitespace" and #field > 0 then
    table.insert(words, field)
  end

  return words
end

local function split_command(line)
  line = line:gsub("%s*\\?%s*$", "")
  local tokens = shellsplit(line)
  if #tokens <= 1 then
    return { line }
  end

  local indent = line:match("^(%s*)") or ""
  local continuation_indent = indent .. "  "

  local result = {}
  for i, token in ipairs(tokens) do
    if i == 1 then
      table.insert(result, indent .. token .. " \\")
    elseif i == #tokens then
      table.insert(result, continuation_indent .. token)
    else
      table.insert(result, continuation_indent .. token .. " \\")
    end
  end
  return result
end

local function run_split(opts)
  local buf = 0
  local line1 = opts.line1
  local line2 = opts.line2

  for row = line2, line1, -1 do
    local original_line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1]
    local split_lines = split_command(original_line)

    if #split_lines > 1 then
      vim.api.nvim_buf_set_lines(buf, row - 1, row, false, split_lines)
    end
  end
end

local function run_join(opts)
  local buf = 0
  local start_row = opts.line1
  local total_lines = vim.api.nvim_buf_line_count(buf)

  local first_row = start_row
  while first_row > 1 do
    local prev = vim.api.nvim_buf_get_lines(buf, first_row - 2, first_row - 1, false)[1]
    if prev:match("\\%s*$") then
      first_row = first_row - 1
    else
      break
    end
  end

  local last_row = first_row
  while last_row <= total_lines do
    local curr = vim.api.nvim_buf_get_lines(buf, last_row - 1, last_row, false)[1]
    if curr:match("\\%s*$") then
      last_row = last_row + 1
    else
      break
    end
  end

  local lines = vim.api.nvim_buf_get_lines(buf, first_row - 1, last_row, false)
  local merged_tokens = {}

  for i, l in ipairs(lines) do
    local cleaned = l:gsub("%s*\\%s*$", "")
    if i > 1 then
      cleaned = cleaned:gsub("^%s*", "")
    end
    if #cleaned > 0 then
      table.insert(merged_tokens, cleaned)
    end
  end

  local merged_line = table.concat(merged_tokens, " ")
  vim.api.nvim_buf_set_lines(buf, first_row - 1, last_row, false, { merged_line })
end

-- Lazy.nvim Plugin Spec
return {
  dir = vim.fn.stdpath("config"),
  name = "shellsplit",
  event = "VeryLazy",
  config = function()
    vim.api.nvim_create_user_command("ShellSplit", run_split,
      { range = true, desc = "Split shell command to multi-line" })
    vim.api.nvim_create_user_command("ShellJoin", run_join,
      { range = true, desc = "Merge multi-line shell command back to single line" })
  end,
}
