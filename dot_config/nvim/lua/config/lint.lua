local linters_by_ft = require('lint').linters_by_ft or {}

if vim.fn.executable('markdownlint-cli2') == 1 then
  linters_by_ft.markdown = {'markdownlint-cli2'}
else
  linters_by_ft.markdown = {}
end

require('lint').linters_by_ft = linters_by_ft
