return {
  "dag/vim-fish",
  "google/vim-jsonnet",
  "junegunn/fzf",
  "junegunn/fzf.vim",
  "khaveesh/vim-fish-syntax",
  "numToStr/Comment.nvim",
  "nvim-tree/nvim-tree.lua",
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
