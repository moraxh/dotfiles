return function()
    local mocha = require("catppuccin.palettes").get_palette "mocha"

    require("bufferline").setup {
        options = {
            buffer_close_icon = "󰅖",
            show_close_icon   = false,
            close_command     = "bdelete! %d",
            separator_style   = "slope",
            diagnostics       = "nvim_lsp",
            numbers           = "none",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    separator = false,
                }
            },
        },
        highlights = require("catppuccin.groups.integrations.bufferline").get {
            styles = { "italic", "bold" },
            custom = {
                all = {
                },
                mocha = {
                    background = { fg = mocha.text },
                },
                latte = {
                },
            },
        },
    }
end
