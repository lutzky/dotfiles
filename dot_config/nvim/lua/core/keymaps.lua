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
  if vim.fn.has("nvim-0.11") == 0 then
      vim.api.nvim_echo({
        { "Can't enable spelling: ",                        "ErrorMsg" },
        { "Using old nvim, lspconfig is probably disabled", "WarningMsg" },
      }, true, {})
      return
  end
  local is_enabled = vim.lsp.is_enabled("cspell_ls")
  if not is_enabled then
    -- mason-lspconfig might not be loaded for this filetype, but user is
    -- requesting spell-check anyway.
    require("lazy").load({ wait = true, plugins = { "mason-lspconfig.nvim" } })

    if vim.fn.executable("cspell-lsp") == 0 and vim.fn.executable("npm") == 0 then
      -- Logic for checking this is usually silent, but user is actively
      -- requesting this now.
      vim.api.nvim_echo({
        { "Probably can't enable spelling: ",         "ErrorMsg" },
        { "Neither cspell-lsp nor npm are available", "WarningMsg" },
      }, true, {})
    end
  end

  vim.lsp.enable("cspell_ls", not is_enabled)
end

vim.keymap.set("n", "<Leader>s", toggle_cspell, {
  desc = "Toggle spell check"
})

vim.cmd('cabbrev W w')
