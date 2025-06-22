require("globals")        -- Global variables

require("config.lazy")

require("core.options")   -- Vim options
require("core.keymaps")   -- Key mappings
require("core.autocmds")  -- Autocommands

require("Comment").setup()

-- If your 'init.work.vim' still contains relevant Vimscript:
vim.cmd("runtime init.work.vim")
-- Consider converting its content to Lua for full Neovim benefits.
