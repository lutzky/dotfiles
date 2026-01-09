vim.api.nvim_set_keymap("n", ";", ":", {
  noremap = true,
  silent = true,
  desc = "Same as :, but lazier"
})

vim.api.nvim_set_keymap("n", "<Leader>w", "<C-w>", {
  noremap = true,
  silent = true,
  desc = "Same as <C-w>, but for when it conflicts"
})


local function toggle_cspell()
  local is_enabled = vim.lsp.is_enabled("cspell_ls")
  vim.lsp.enable("cspell_ls", not is_enabled)
end

vim.keymap.set("n", "<Leader>s", toggle_cspell, {
  desc = "Toggle spell check"
})

vim.cmd('cabbrev W w')
