vim.opt.signcolumn = "auto:4"

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs", -- Apply to all Rust files
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
  desc = "Format Rust file on save",
})
