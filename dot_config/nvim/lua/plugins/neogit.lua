return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "nvim-telescope/telescope.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>",                 desc = "Show Neogit UI" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches in Telescope" }
  }
}
