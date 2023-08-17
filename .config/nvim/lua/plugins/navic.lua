return function()
    require("nvim-navic").setup({
        separator   = "  ",
        highlight   = true,
        click       = true,
        lsp = {
            auto_attach = true,
        },
    })
end
