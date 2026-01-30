vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    if client and client.supports_method("textDocument/codeLens") then
      vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
        buffer = bufnr,
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = bufnr })
        end,
      })

      vim.keymap.set("n", "<leader>cr", vim.lsp.codelens.run, {
        buffer = bufnr,
        desc = "LSP CodeLens Run"
      })
    end
  end,
})

return {
  "neovim/nvim-lspconfig",
  lazy = true,
  cond = vim.fn.has("nvim-0.11") == 1,
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },

  ft = lsp_enabled_filetypes,

  config = function()
    vim.lsp.config.markdown_oxide = {
      -- Override the *order* of these, as we'll sometimes have the root in a
      -- subdirectory of a git repo.
      root_markers = { ".moxide.toml", ".obsidian", ".git" }
    }

    -- These are needed for non-mason binaries, or binaries that we sometimes
    -- might install outside of mason.
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('markdown_oxide')
    vim.lsp.enable('pyright')
  end,
}
