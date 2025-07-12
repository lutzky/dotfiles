return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      require("telescope").setup {
        extensions = {
          fzf = {}
        }
      }

      require("telescope").load_extension("fzf")

      vim.keymap.set("n", "<leader>fd", require("telescope.builtin").find_files,
        { desc = "Find files with telescope" }
      )
      vim.keymap.set("n", "<leader>fk", require("telescope.builtin").keymaps,
        { desc = "Find keymaps with telescope" }
      )
      vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep,
        { desc = "Telescope live-grep" }
      )
    end,
}
