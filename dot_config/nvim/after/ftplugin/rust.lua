local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
  "n",
  "<leader>a",
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr, desc = "RustLSP Code action" }
)
vim.keymap.set(
  "n",
  "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({ 'hover', 'actions' })
  end,
  { silent = true, buffer = bufnr, desc = "RustLSP Hover action" }
)

-- Use CTRL-W CTRL-W to focus the error
vim.keymap.set("n", "<leader>re", function()
  vim.cmd.RustLsp('explainError')
end, { desc = "Rust Explain Error" })

vim.keymap.set("n", "<leader>rd", function()
  vim.cmd.RustLsp('renderDiagnostic')
end, { desc = "Rust Render Diagnostic" })
