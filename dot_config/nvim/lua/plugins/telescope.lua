local spec = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      cond = is_build_system,
      build = 'make'
    },
  },
  config = function()
    require("telescope").setup {
      extensions = {
        fzf = {}
      }
    }

    if is_build_system then
      require("telescope").load_extension("fzf")
    end

    vim.keymap.set("n", "<leader>fd", require("telescope.builtin").find_files,
      { desc = "Find files with telescope" }
    )
    vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep,
      { desc = "Telescope live-grep" }
    )
    vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags,
      { desc = "Find help tags with telescope" }
    )
    vim.keymap.set("n", "<leader>fk", require("telescope.builtin").keymaps,
      { desc = "Find keymaps with telescope" }
    )
    vim.keymap.set("n", "<leader>fs", require("telescope.builtin").lsp_dynamic_workspace_symbols,
      { desc = "Find LSP symbols with telescope" }
    )
  end,
}

return spec
