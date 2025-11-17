return {
  "neovim/nvim-lspconfig",
  lazy = true,
  cond = vim.fn.has("nvim-0.11") == 1,

  ft = { 'python' },

  config = function()
    vim.lsp.enable('pyright')
  end,
}
