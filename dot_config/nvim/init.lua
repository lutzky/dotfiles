require("globals")

require("config.lazy")

require("config.date_picker")
require("config.projects")
require("config.toggle_visual_wrap")
require("config.vue")

require("core.autocmds")
require("core.clipboard")
require("core.diagnostic")
require("core.inlay")
require("core.keymaps")
require("core.options")

vim.cmd.runtime("lua/work/init.lua")
