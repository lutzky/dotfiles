return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      vue = { "prettier" },
      rust =  { "rustfmt", lsp_format = "fallback" },
    },
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 500,
    },
  },
}
