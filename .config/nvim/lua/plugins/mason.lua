return function()
    require("mason").setup()
    require("mason-lspconfig").setup{ automatic_installation = true }
end
