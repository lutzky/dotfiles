vim.lsp.inlay_hint.enable(true)

vim.keymap.set(
  "n",
  "<leader>di",
  function()
    local hint = vim.lsp.inlay_hint
    hint.enable(not hint.is_enabled())
  end,
  { desc = "Toggle inlay hints" }
)
