return {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function(buffer)
      local gs = require('gitsigns')
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = buffer
        vim.keymap.set(mode, l, r, opts)
      end
      map("n", "]g", function() gs.nav_hunk('next') end, { desc = "Next git hunk" })
      map("n", "[g", function() gs.nav_hunk('prev') end, { desc = "Previous git hunk" })

      map("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage git hunk" })
      map("n", "<leader>ghr", gs.reset_hunk, { desc = "Reset git hunk" })
      map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview hunk" })
      map("n", "<leader>ghi", gs.preview_hunk_inline, { desc = "Inline preview hunk" })
      map('v', '<leader>ghr', function()
        gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end)


      map("n", "<leader>gd", gs.diffthis, { desc = "Git diff" }) -- cSpell:disable-line
      map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { desc = "Git blame" })
      map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle git blame" })
      map("n", "<leader>gw", gs.toggle_word_diff, { desc = "Toggle word diff" })
    end
  }
}
