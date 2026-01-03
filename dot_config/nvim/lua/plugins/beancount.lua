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

local function append_guess()
  local input = vim.api.nvim_get_current_line()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local buf = vim.api.nvim_get_current_buf()

  local budget_root = vim.fs.joinpath(vim.env.HOME, "budget")
  local guess_binary = vim.fs.joinpath(budget_root, "guess.py")
  local journal_file = vim.fs.joinpath(budget_root, "main.bean")

  vim.system({ guess_binary, "--file=" .. journal_file }, { stdin = input }, function(obj)
    vim.schedule(function()
      if obj.code == 0 then
        local output = vim.split(obj.stdout, "\n", { trimempty = true })
        vim.api.nvim_buf_set_lines(buf, row, row, false, output)
      else
        print("Error: " .. obj.stderr)
      end
    end)
  end)
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

      vim.keymap.set('n', '<leader>bg', append_guess,
        { desc = "Budget: Guess account" })

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
