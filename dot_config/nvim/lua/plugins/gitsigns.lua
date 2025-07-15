return {
  "lewis6991/gitsigns.nvim",
  config = function()
    vim.keymap.set("n", "]g", function()
      require('gitsigns').nav_hunk('next')
    end, { desc = "Next git hunk" })
    vim.keymap.set("n", "[g", function()
      require('gitsigns').nav_hunk('prev')
    end, { desc = "Previous git hunk" })
  end
}
