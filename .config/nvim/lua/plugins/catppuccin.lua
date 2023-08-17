return function()
    require("catppuccin").setup({
        transparent_background = false,
        styles = {
            comments = { "italic" },
            conditionals = { "italic" },
            loops = {},
            functions = { "bold", "italic" },
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = { "bold" },
            properties = {},
            types = {},
            operators = { "bold" },
        },
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            telescope = true,
            navic = {
                enabled = true,
                custom_bg = "NONE",
            },
        },
    })

    cmd[[colorscheme catppuccin-mocha]]
end
