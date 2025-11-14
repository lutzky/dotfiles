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
  "tpope/vim-fugitive",
  "tpope/vim-sleuth",

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
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
    config = function(_, opts)
      require("jellybeans").setup(opts)
      vim.cmd[[colorscheme jellybeans]]
    end,
  },
}
