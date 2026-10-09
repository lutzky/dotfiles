return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter',
        cond = function()
          return vim.fn.executable('cc') == 1
              or vim.fn.executable('gcc') == 1
              or vim.fn.executable('clang') == 1
        end,
      },
      'nvim-tree/nvim-web-devicons'
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = {
        lsp = { enabled = true },
      },
      checkbox = {
        checked = {
          scope_highlight = '@markup.strikethrough' }
      },
    },
  },
  {
    'opdavies/toggle-checkbox.nvim', -- cspell: disable-line
    keys = {
      {
        "<leader>tt",
        function()
          require('toggle-checkbox').toggle()
        end,
        desc = "Toggle checkbox on current line"
      } },
  }
}
