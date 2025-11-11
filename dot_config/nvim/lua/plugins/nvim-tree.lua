return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
        diagnostics = {
          enable = true,
          show_on_dirs = true,
        }
      })
    end,
    keys = {
      { "<Leader>tr", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
    },
  }
}
