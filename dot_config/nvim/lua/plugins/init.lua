return {
  {
    "dag/vim-fish",
    lazy = true,
    ft = { "fish" },
  },
  {
    "google/vim-jsonnet",
    lazy = true,
    ft = { "jsonnet" },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  "junegunn/fzf",
  "junegunn/fzf.vim",
  "numToStr/Comment.nvim",
  "tpope/vim-sleuth",

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
    },
  },

  {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
    config = function(_, opts)
      require("jellybeans").setup(opts)
      vim.cmd [[colorscheme jellybeans]]
    end,
  },
}
