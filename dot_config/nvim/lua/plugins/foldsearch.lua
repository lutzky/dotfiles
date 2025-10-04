return {
  "embear/vim-foldsearch",
  init = function()
    -- Disable key mappings, as they conflict with my telescope.lua mappings,
    -- and I don't use this often enough to justify having them anyway.
    vim.g.foldsearch_disable_mappings = 1
  end
}
