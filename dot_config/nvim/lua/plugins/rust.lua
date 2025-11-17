return {
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = true,
    ft = { 'rust' },
    dependencies = {
      "j-hui/fidget.nvim", -- Show LSP status
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },
  },
}
