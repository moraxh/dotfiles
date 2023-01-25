require('lspconfig').clangd.setup{}

vim.diagnostic.config({
    update_in_insert = true,
    signs = false,
})
