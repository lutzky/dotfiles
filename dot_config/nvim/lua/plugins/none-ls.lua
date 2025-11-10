return {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    cond = vim.fn.executable("cspell") == 1,
    dependencies = { "davidmh/cspell.nvim" },
    lazy = true,
    keys = { "<leader>s", desc = "Enable spell check" },
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
  },
}
