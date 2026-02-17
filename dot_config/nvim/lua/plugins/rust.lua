return {
  {
    'mrcjkb/rustaceanvim',
    version = '^8',
    lazy = true,
    ft = { 'rust' },
    dependencies = {
      "j-hui/fidget.nvim", -- Show LSP status
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },
  },
}
