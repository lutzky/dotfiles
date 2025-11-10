return {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    cond = vim.fn.executable("cspell") == 1,
    dependencies = { "davidmh/cspell.nvim", "j-hui/fidget.nvim" },
    lazy = true,
    keys = { "<leader>s", desc = "Toggle spell check" },
    opts = function(_, opts)
      local cspell = require("cspell")
      opts.sources = opts.sources or {}
      table.insert(
        opts.sources,
        cspell.diagnostics.with({
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
          end,
        })
      )
      table.insert(opts.sources, cspell.code_actions)
    end,
    config = function(_, opts)
      local null_ls = require("null-ls")
      local fidget = require("fidget")
      null_ls.setup(opts)

      local function get_cspell_namespace()
        local cspell_sources = require("null-ls.sources").get({ name = "cspell" })
        if not cspell_sources or #cspell_sources == 0 then
          return nil
        end
        return require("null-ls.diagnostics").get_namespace(cspell_sources[1].id)
      end

      local function toggle_cspell_diagnostics()
        local namespace = get_cspell_namespace()
        if not namespace then
          fidget.notify("CSpell source not found", vim.log.levels.WARN)
          return
        end

        if vim.diagnostic.is_enabled({ ns_id = namespace }) then
          vim.diagnostic.enable(false, { ns_id = namespace })
          fidget.notify("CSpell diagnostics disabled", vim.log.levels.INFO)
        else
          vim.diagnostic.enable(true, { ns_id = namespace })
          fidget.notify("CSpell diagnostics enabled", vim.log.levels.INFO)
        end
      end

      vim.keymap.set('n', '<leader>s', toggle_cspell_diagnostics, {
        desc = "Toggle spell check"
      })
    end,
  },
}
