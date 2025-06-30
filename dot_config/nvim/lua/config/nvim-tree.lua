vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  }
})

vim.api.nvim_set_keymap('n', '<Leader>tr', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
