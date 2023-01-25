require('indent_blankline').setup {
    enabled = true,
    show_trailing_blankline_indent = false,
    colored_indent_levels = false,
    show_first_indent_level = true,
    char = '▏',
    filetype_exclude = {
        'dashboard',
        'NvimTree',
        'help'
    }
}
