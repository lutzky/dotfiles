local function date_picker()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local DAY_SECONDS = 60 * 60 * 24

  local function n_days_from_now(n, extra_spec)
    extra_spec = extra_spec or ""
    return os.date("%Y-%m-%d" .. extra_spec, os.time() + DAY_SECONDS * n)
  end

  local options = {}
  local human_options = {
    { "Today",              0 },
    { "Tomorrow",           1 },
    { "Day after tomorrow", 2 },
    { "In one week",        7 },
    { "In two weeks",       14 },
  }

  for _, pair in ipairs(human_options) do
    table.insert(options, {
      display = pair[1] .. " (" .. n_days_from_now(pair[2]) .. ")",
      value = n_days_from_now(pair[2]),
    })
  end

  for n = 1, 365 do
    table.insert(options, {
      display = n_days_from_now(n, " (%A)"),
      value = n_days_from_now(n),
    })
  end

  pickers.new({}, {
    prompt_title = "Pick a Date",
    finder = finders.new_table({
      results = options,
      entry_maker = function(entry)
        return {
          value = entry.value,
          display = entry.display,
          ordinal = entry.display,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.api.nvim_put({ selection.value }, "c", true, true)
      end)
      return true
    end,
  }):find()
end

vim.api.nvim_create_user_command("DatePicker", date_picker, {})
