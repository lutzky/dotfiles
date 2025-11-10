require("globals")

require("config.lazy")

require("config.vue")

require("core.autocmds")
require("core.clipboard")
require("core.diagnostic")
require("core.inlay")
require("core.keymaps")
require("core.options")

require("Comment").setup()

-- If your 'init.work.vim' still contains relevant Vimscript:
vim.cmd.runtime("init.work.vim")
-- Consider converting its content to Lua for full Neovim benefits.
