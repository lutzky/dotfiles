return {
  -- Plugins from your vimrc:
  "airblade/vim-gitgutter",
  "dag/vim-fish",
  "google/vim-jsonnet",
  -- Note: lightline and jellybeans are defined below with their configs
  "junegunn/fzf",
  "junegunn/fzf.vim",
  "khaveesh/vim-fish-syntax",
  "tpope/vim-fugitive",
  "tpope/vim-sleuth",

  -- Configuration for lightline.vim
  {
    "itchyny/lightline.vim",
    config = function()
      vim.g.lightline = {
        active = {
          left = { { "mode", "paste" }, { "fugitive", "readonly", "filename", "modified" } },
        },
	colorscheme = "jellybeans",
        component_function = { fugitive = "fugitive#statusline" },
      }
    end,
  },

  -- Configuration for jellybeans.vim and colorscheme
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
