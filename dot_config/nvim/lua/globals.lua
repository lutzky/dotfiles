vim.g.mapleader = ","

lsp_enabled_filetypes = {
  'lua',
  'markdown',
  'python',
  'rust',
  'typescript',
  'typst',
  'vue',
}

is_build_system = vim.fn.executable("make") == 1 and vim.fn.executable("cc") == 1
