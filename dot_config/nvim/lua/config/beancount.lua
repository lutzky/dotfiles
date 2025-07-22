local lspconfig = require('lspconfig')
lspconfig.beancount.setup({
  init_options = {
    -- We'd really like to just have relative-to-git-root path here, and this
    -- *should* be facilitated by `root_markers`, but doesn't seem to work.
    -- Potential fix (2025-04-04):
    -- https://github.com/polarmutex/beancount-language-server/commit/a4e26529ad8715bbe4fbe6ed97ab6c4121709b0b#commitcomment-161469363
    journal_file = vim.fn.expand(os.getenv("BEANCOUNT_FILE") or "~/budget/main.bean"),
  }
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.bean",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
  desc = "Format Beancount file on save",
})
