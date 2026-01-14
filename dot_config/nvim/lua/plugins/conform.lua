return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      vue = { "prettier" },
      cpp = { "clang-format" },
      rust = { "rustfmt", lsp_format = "fallback" },
    },
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 500,
    },
  },
}
