return {
  "dag/vim-fish",
  "google/vim-jsonnet",
  "junegunn/fzf",
  "junegunn/fzf.vim",
  "khaveesh/vim-fish-syntax",
  "lewis6991/gitsigns.nvim",
  "numToStr/Comment.nvim",
  "nvim-tree/nvim-tree.lua",
  "tpope/vim-fugitive",
  "tpope/vim-sleuth",

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  {
    "itchyny/lightline.vim",
    config = function()
      vim.g.lightline = {
        active = {
          left = { { "mode", "paste" }, { "fugitive", "readonly", "absolutepath", "modified" } },
        },
        colorscheme = "jellybeans",
        component_function = { fugitive = "fugitive#statusline" },
      }
    end,
  },

  {
    "nanotech/jellybeans.vim",
    init = function()
      vim.g.jellybeans_use_term_italics = 1
      vim.g.jellybeans_overrides = {
        background = { guibg = "none" },
      }
      vim.cmd("colorscheme jellybeans")
    end,
  },
}
