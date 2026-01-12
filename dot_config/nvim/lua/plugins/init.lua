function _G.gitsigns_status()
  -- For lightline
  local dict = vim.b.gitsigns_status_dict
  if not dict or dict.head == "" then return "" end
  return " " .. dict.head
end

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
    "itchyny/lightline.vim",
    config = function()
      vim.g.lightline = {
        active = {
          left = { { "mode", "paste" }, { "git", "readonly", "absolutepath", "modified" } },
        },
        colorscheme = "jellybeans",
        component_function = { git = "v:lua.gitsigns_status" },
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
      vim.cmd [[colorscheme jellybeans]]
    end,
  },
}
