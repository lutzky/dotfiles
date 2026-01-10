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

if vim.fn.has('nvim-0.11') == 1 then
  -- See https://www.reddit.com/r/neovim/comments/1kdniew/can_someone_help_how_to_add_border_to_hover/
  vim.o.winborder = 'rounded'
end

-- Avoid "CursorHold", as it conflicts with other floats that we open. To see
-- diagnostics, use <C-W><C-D>.

vim.o.updatetime = 300      -- milliseconds (e.g., 300ms)
vim.o.signcolumn = "auto:4" -- Room to show gitsigns + diagnostics
