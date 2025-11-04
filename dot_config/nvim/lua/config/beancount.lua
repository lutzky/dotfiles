local lspconfig = require('lspconfig')

-- Check if beancount-language-server is available
local function check_beancount_ls(show_warnings)
  show_warnings = show_warnings ~= false  -- default to true
  local ok, mason_registry = pcall(require, 'mason-registry')
  if not ok then
    if show_warnings then
      vim.notify(
        "beancount-language-server not found, and also Mason isn't installed",
        vim.log.levels.WARN,
        { title = "Beancount LSP" }
      )
    end
    return false
  end

  if not mason_registry.is_installed('beancount-language-server') then
    if show_warnings then
      vim.notify(
        "beancount-language-server not found. Run :MasonInstall beancount-language-server to install it.",
        vim.log.levels.WARN,
        { title = "Beancount LSP" }
      )
    end
    return false
  end
  return true
end

-- Setup LSP with availability check
local function setup_beancount_lsp()
  if check_beancount_ls(true) then
    lspconfig.beancount.setup({
      init_options = {
        -- We'd really like to just have relative-to-git-root path here, and this
        -- *should* be facilitated by `root_markers`, but doesn't seem to work.
        -- Potential fix (2025-04-04):
        -- https://github.com/polarmutex/beancount-language-server/commit/a4e26529ad8715bbe4fbe6ed97ab6c4121709b0b#commitcomment-161469363
        journal_file = vim.fn.expand(os.getenv("BEANCOUNT_FILE") or "~/budget/main.bean"),
      }
    })
  end
end

-- Setup when a beancount file is opened
vim.api.nvim_create_autocmd("FileType", {
  pattern = "beancount",
  callback = setup_beancount_lsp,
  desc = "Setup Beancount LSP when opening beancount files",
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.bean",
  callback = function()
    if check_beancount_ls(false) then
      vim.lsp.buf.format({ async = false })
    end
  end,
  desc = "Format Beancount file on save",
})
