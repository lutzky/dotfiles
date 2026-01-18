return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      cpp = { "clang-format" },
      fish = { "fish_indent" },
      rust = { "rustfmt", lsp_format = "fallback" },
      vue = { "prettier" },
    },
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 500,
    },
  },
}
