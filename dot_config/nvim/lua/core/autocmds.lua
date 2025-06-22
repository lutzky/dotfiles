vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.paste = false
  end,
})
