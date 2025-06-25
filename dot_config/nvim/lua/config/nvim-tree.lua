vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

vim.cmd[[map <Leader>tr :NvimTreeOpen<CR>]]
