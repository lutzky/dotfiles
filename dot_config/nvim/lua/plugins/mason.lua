local ensure_installed = { "lua_ls" }

if require("os").getenv("NVIM_ENABLE_VUE") then
    table.insert(ensure_installed, "vue_ls")
    table.insert(ensure_installed, "ts_ls")
end

if vim.fn.executable('npm') == 1 then
    table.insert(ensure_installed, "cspell_ls")
end

return {
    "mason-org/mason-lspconfig.nvim",
    lazy = true,
    cond = (#ensure_installed > 0) and (vim.fn.has('nvim-0.11') == 1),
    opts = {},

    ft = lsp_enabled_filetypes,

    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
    end
}
