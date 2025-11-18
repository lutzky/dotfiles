return {
  "neovim/nvim-lspconfig",
  lazy = true,
  cond = vim.fn.has("nvim-0.11") == 1,
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },

  ft = lsp_enabled_filetypes,

  config = function()
    vim.lsp.enable('pyright')
    vim.lsp.enable("lua_ls")
  end,
}
