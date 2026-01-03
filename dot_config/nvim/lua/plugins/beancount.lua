local enable_beancount = vim.fn.has("nvim-0.11") == 1

local function check_beancount_deps()
  local fidget = require("fidget")

  if vim.fn.executable('bean-check') == 0 then
    fidget.notify(
      'Warning: bean-check not found in PATH. You may have forgotten to activate your beancount venv.',
      vim.log.levels.WARN,
      { ttl = 30 }
    )
  end

  if vim.fn.executable('beancount-language-server') == 0 then
    fidget.notify(
      'Warning: beancount-language-server not found. Install it with :MasonInstall beancount-language-server',
      vim.log.levels.WARN,
      { ttl = 30 }
    )
  end
end

return {
  {
    "nathangrigg/vim-beancount", -- cspell:disable-line
    lazy = true,
    ft = { "beancount" },
    dependencies = {
      -- cspell:disable
      "j-hui/fidget.nvim",
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
      -- cspell:enable
    },
    cond = enable_beancount,

    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'beancount',
        callback = function()
          check_beancount_deps()
        end,
      })

      vim.lsp.config('beancount', {
        -- cmd = {
        --   "beancount-language-server",
        --   "--stdio",
        --   -- "--log",
        -- },
        init_options = {
          -- journal_file = vim.fn.expand(os.getenv("BEANCOUNT_FILE") or "~/budget/main.bean"),
          journal_file = "main.bean", -- Seems to work relative to .git
        }
      })
      vim.lsp.enable('beancount')
    end
  },
}
