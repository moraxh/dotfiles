require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'catppuccin',
        section_separators = { left = '', right = ''},
        always_divide_middle = false,
        disabled_filetypes = { 'dashboard', 'NvimTree' },
    },
    sections = {
        lualine_a = { 'mode' },

        lualine_b = {
            { 'branch' },
            {
                'diagnostics',

                sources = { 'nvim_lsp' },

                sections = { 'error', 'warn' },

                diagnostics_color = {
                    error = { fg = '#DC6068' },
                    warn  = { fg = '#E6B455' },
                },
                symbols = { error = ' ', warn = ' ' },
                colored = true,
                update_in_insert = false,
                always_visible = false,
            },
        },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'filesize' },
        lualine_z = { 'location' },
    }
}
