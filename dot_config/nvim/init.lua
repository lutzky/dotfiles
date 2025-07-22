require("globals")

require("config.lazy")

require("config.beancount")
require("config.lint")
require("config.nvim-tree")
require("config.rust")

require("core.autocmds")
require("core.diagnostic")
require("core.inlay")
require("core.keymaps")
require("core.options")

require("Comment").setup()

-- If your 'init.work.vim' still contains relevant Vimscript:
vim.cmd.runtime("init.work.vim")
-- Consider converting its content to Lua for full Neovim benefits.
