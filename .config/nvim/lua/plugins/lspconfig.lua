require('lspconfig').clangd.setup{}
require('lspconfig').pyright.setup{}

vim.diagnostic.config({
    update_in_insert = true,
    signs = false,
})
