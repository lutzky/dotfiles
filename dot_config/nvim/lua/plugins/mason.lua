local ensure_installed = {}

if require("os").getenv("NVIM_ENABLE_VUE") then
    table.insert(ensure_installed, "vue_ls")
    table.insert(ensure_installed, "ts_ls")
end

return {
    "mason-org/mason-lspconfig.nvim",
    lazy = true,
    cond = #ensure_installed > 0,
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    config = function ()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "vue_ls",
                "ts_ls",
            },
        })
    end
}
