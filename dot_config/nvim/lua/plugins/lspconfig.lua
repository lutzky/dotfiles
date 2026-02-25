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

local function lua_ls_config()
  -- Copied from `:help lspconfig-all`

  vim.lsp.config('lua_ls', {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
            path ~= vim.fn.stdpath('config')
            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using (most
          -- likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Tell the language server how to find Lua modules same way as Neovim
          -- (see `:h lua-module-load`)
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- Depending on the usage, you might want to add additional paths
            -- here.
            -- '${3rd}/luv/library'
            -- '${3rd}/busted/library'
          }
          -- Or pull in all of 'runtimepath'.
          -- NOTE: this is a lot slower and will cause issues when working on
          -- your own configuration.
          -- See https://github.com/neovim/nvim-lspconfig/issues/3189
          -- library = {
          --   vim.api.nvim_get_runtime_file('', true),
          -- }
        }
      })
    end,
    settings = {
      Lua = {}
    }
  })
end

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
    local moxide_local_development_copy = vim.fn.expand(
      "~/src/markdown-oxide/target/debug/markdown-oxide"
    )

    local moxide_cfg = {
      -- Override the *order* of these, as we'll sometimes have the root in a
      -- subdirectory of a git repo.
      root_markers = { ".moxide.toml", ".obsidian", ".git" }
    }

    if vim.uv.fs_stat(moxide_local_development_copy) then
      moxide_cfg.cmd = { moxide_local_development_copy }
    end

    lua_ls_config()

    vim.lsp.config.markdown_oxide = moxide_cfg

    -- These are needed for non-mason binaries, or binaries that we sometimes
    -- might install outside of mason.
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('markdown_oxide')
    vim.lsp.enable('pyright')
  end,
}
