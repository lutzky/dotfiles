if vim.fn.has("nvim-0.11") == 0 then
  return
end

local fidget = require("fidget")

local function check_beancount_deps()
  if vim.fn.executable('bean-check') == 0 then
    fidget.notify(
      'Warning: bean-check not found in PATH. You may have forgotten to activate your beancount venv.',
      vim.log.levels.WARN,
      { ttl = 30 }
    )
  end

  if vim.fn.executable('beancount-language-server') == 0 then
    fidget.notify(
      'Warning: beancount-language-server not found. Install it with :MasonInstall beancount-language-server',
      vim.log.levels.WARN,
      { ttl = 30 }
    )
  end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'beancount',
  callback = function()
    check_beancount_deps()
  end,
})

vim.lsp.config('beancount', {
  -- cmd = {
  --   "beancount-language-server",
  --   "--stdio",
  --   -- "--log",
  -- },
  init_options = {
    -- journal_file = vim.fn.expand(os.getenv("BEANCOUNT_FILE") or "~/budget/main.bean"),
    journal_file = "main.bean", -- Seems to work relative to .git
  }
})
vim.lsp.enable('beancount')
