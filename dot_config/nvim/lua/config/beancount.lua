vim.lsp.config('beancount', {
  cmd = {
    "beancount-language-server",
    "--stdio",
    -- "--log",
  },
  init_options = {
    -- journal_file = vim.fn.expand(os.getenv("BEANCOUNT_FILE") or "~/budget/main.bean"),
    journal_file = "main.bean", -- Seems to work relative to .git
  }
})
vim.lsp.enable('beancount')
