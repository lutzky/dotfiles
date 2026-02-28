-- Avoid using the system clipboard by default, as you tend to clobber it by deleting something right before you paste something else.
-- vim.opt.clipboard = "unnamedplus"

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

if vim.env.TMUX then
  vim.g.clipboard = {
    name = "tmux",
    copy = {
      ["+"] = { "tmux", "load-buffer", "-w", "-" },
      ["*"] = { "tmux", "load-buffer", "-w", "-" },
    },
    paste = {
      ["+"] = { "tmux", "save-buffer", "-" },
      ["*"] = { "tmux", "save-buffer", "-" },
    },
    cache_enabled = 1,
  }
elseif vim.fn.has("nvim-0.10") == 1 then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = paste,
      ['*'] = paste,
    }
    -- -- This doesn't work as some terminals block OSC52 pasting for security
    -- -- concerns
    -- paste = {
    --   ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    --   ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    -- },
  }
end
