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
        local guess_output = vim.split(obj.stdout, "\n", { trimempty = true })

        -- Seek an empty line within the next 10 lines to try and append it to the block;
        -- otherwise, put it right under the current line.
        local lines = vim.api.nvim_buf_get_lines(buf, row - 1, row + 10, false)
        local insert_row = row
        for i, line in ipairs(lines) do
          if line == "" then
            insert_row = row - 2 + i
            break
          end
        end
        vim.api.nvim_buf_set_lines(buf, insert_row, insert_row, false, guess_output)
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
          vim.opt_local.foldmethod = "manual"
        end,
      })

      vim.keymap.set('n', '<leader>bg', append_guess,
        { desc = "Budget: Guess account" })

      if not os.getenv("NVIM_RLEDGER") then
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
      else
        vim.lsp.enable('beancount', false)
        -- Add to your Neovim config
        local lspconfig = require('lspconfig')
        local configs = require('lspconfig.configs')

        -- cSpell: word rledger

        -- Register rledger-lsp if not already defined
        if not configs.rledger then
          configs.rledger = {
            default_config = {
              cmd = { 'rledger-lsp' },
              filetypes = { 'beancount' },
              root_dir = lspconfig.util.root_pattern('.git', '*.beancount', '*.bean'),
              settings = {},
            },
          }
        end

        lspconfig.rledger.setup {}
      end
    end
  },
}
