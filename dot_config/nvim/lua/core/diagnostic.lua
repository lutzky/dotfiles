vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  pattern = "*", -- Apply to all file types
  callback = function()
    -- Check if there are diagnostics at the current cursor position
    local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })

    if diagnostics and #diagnostics > 0 then
      -- Open the float, making it not focusable so you can still type
      vim.diagnostic.open_float(nil, { focusable = false })
    end
  end,
  desc = "Show diagnostic on CursorHold",
})

vim.o.updatetime = 300 -- milliseconds (e.g., 300ms)
