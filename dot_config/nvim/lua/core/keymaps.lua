-- Extra laziness for ex-:
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = true })

-- Workaround for Ctrl-W not working in browser tabs (and general use)
vim.api.nvim_set_keymap("n", "<Leader>w", "<C-w>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Leader>ts", ":Telescope<CR>", {})
