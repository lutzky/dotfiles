vim.g.visual_wrap_mode = false

local function toggle_visual_wrap()
  vim.g.visual_wrap_mode = not vim.g.visual_wrap_mode

  vim.opt.linebreak = vim.g.visual_wrap_mode
  vim.opt.smoothscroll = vim.g.visual_wrap_mode

  if vim.g.visual_wrap_mode then
    vim.keymap.set('n', 'j', 'gj', { noremap = true, silent = true })
    vim.keymap.set('n', 'k', 'gk', { noremap = true, silent = true })
    print("Visual wrap movement (gj/gk)")
  else
    vim.keymap.del('n', 'j')
    vim.keymap.del('n', 'k')
    print("Standard movement (j/k)")
  end
end

vim.keymap.set('n', '<Leader>gj', toggle_visual_wrap, { desc = "Toggle gj/gk movement" })
