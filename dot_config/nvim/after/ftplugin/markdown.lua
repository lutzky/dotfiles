vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    if vim.fn.executable('markdownlint-cli2') == 1 then
      require("lint").try_lint()
    else
      _G.markdown_linter_notice_shown = _G.markdown_linter_notice_shown or false
      if not _G.markdown_linter_notice_shown then
        vim.notify(
          'Linter "markdownlint-cli2" not found. Markdown linting is disabled.',
          vim.log.levels.INFO,
          {title = 'nvim-lint'}
        )
        _G.markdown_linter_notice_shown = true
      end
    end
  end,
})
