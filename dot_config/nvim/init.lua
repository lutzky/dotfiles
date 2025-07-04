require("globals")

require("config.lazy")
require("config.rust")
require("config.nvim-tree")
require("config.beancount")

require("core.autocmds")
require("core.diagnostic")
require("core.inlay")
require("core.keymaps")
require("core.options")

require("Comment").setup()
require("telescope").setup()

-- If your 'init.work.vim' still contains relevant Vimscript:
vim.cmd("runtime init.work.vim")
-- Consider converting its content to Lua for full Neovim benefits.
