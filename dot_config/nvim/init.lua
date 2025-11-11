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

vim.cmd.runtime("lua/work/init.lua")
