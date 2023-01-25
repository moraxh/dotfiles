local mocha = require("catppuccin.palettes").get_palette "mocha"

require('bufferline').setup {
    options = {
        show_tab_indicators = false,
        show_close_icon = false,
        separator_style = 'thick',
        numbers = 'none',
        always_show_bufferline = true,
        offsets = {
            {
                filetype = "NvimTree",
                text = "NvimTree",
                highlight = "Directory"
            }
        },
        highlights = require("catppuccin.groups.integrations.bufferline").get {
                styles = { "italic", "bold" },
                custom = {
                    all = {
                        fill = { bg = "#000000" },
                    },
                    mocha = {
                        background = { fg = mocha.text },
                    },
                    latte = {
                        background = { fg = "#000000" },
                    },
                },
            },
    }
}
