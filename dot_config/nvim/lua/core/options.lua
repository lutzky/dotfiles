vim.opt.mouse = "nv"

-- Incremental command preview
vim.opt.inccommand = "split"

vim.opt.splitright = true

-- Highlight unwanted characters (listchars)
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '‰' }

-- Always show statusline
vim.opt.laststatus = 2

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
