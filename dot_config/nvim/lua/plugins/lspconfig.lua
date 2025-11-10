return {
  "neovim/nvim-lspconfig",
  lazy = true,
  cond = vim.fn.has("nvim-0.11") == 1,
}
