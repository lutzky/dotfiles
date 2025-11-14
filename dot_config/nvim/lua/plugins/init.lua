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
    "nanotech/jellybeans.vim",
    init = function()
      vim.g.jellybeans_use_term_italics = 1
      vim.g.jellybeans_overrides = {
        background = { guibg = "none" },
      }
      vim.cmd.colorscheme("jellybeans")
    end,
  },
}
