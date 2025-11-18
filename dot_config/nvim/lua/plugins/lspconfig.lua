return {
  "neovim/nvim-lspconfig",
  lazy = true,
  cond = vim.fn.has("nvim-0.11") == 1,

  ft = lsp_enabled_filetypes,

  config = function()
    vim.lsp.enable('pyright')
  end,
}
