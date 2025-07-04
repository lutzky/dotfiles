vim.lsp.enable('beancount')
vim.lsp.config('beancount', {
  init_options = {
    journal_file = vim.fn.expand(os.getenv("BEANCOUNT_FILE") or "~/budget/main.bean"),
  };
});
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.bean",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
  desc = "Format Beancount file on save",
})
