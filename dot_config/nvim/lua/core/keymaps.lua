vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = true,
  desc = "Same as :, but lazier"})

vim.api.nvim_set_keymap("n", "<Leader>w", "<C-w>", { noremap = true, silent = true,
  desc = "Same as <C-w>, but for when it conflicts" })
