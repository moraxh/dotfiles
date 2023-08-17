return function()
	require("indent_blankline").setup({
        show_trailing_blankline_indent  = false,
        show_current_context_start      = true,
        show_first_indent_level         = true,
        space_char_blankline            = " ",
        show_current_context            = true,
        colored_indent_levels           = false,
        enabled                         = true,
	    char                            = '│',
	    filetype_exclude = {
            "dashboard",
            "NvimTree",
            "help"
	    },
	})
    cmd("highlight IndentBlanklineChar guifg=#585b70 gui=nocombine")
    cmd("highlight IndentBlanklineContextChar guifg=#fab387 gui=nocombine")
    cmd("highlight IndentBlanklineContextStart guifg=#fab387 gui=underline")
end
