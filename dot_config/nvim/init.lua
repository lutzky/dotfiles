require("globals")

require("config.lazy")

require("config.vue")
require("config.date_picker")

require("core.autocmds")
require("core.clipboard")
require("core.diagnostic")
require("core.inlay")
require("core.keymaps")
require("core.options")

vim.cmd.runtime("lua/work/init.lua")
