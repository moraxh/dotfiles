-- TODO
-- FIX
-- HACK
-- WARN
-- PERF
-- NOTE
return function()
	require('todo-comments').setup{
        merge_keywords  = true,
        sign_priority   = 8,
        signs           = true,
        keywords = {
            FIX  = { icon = " ", color = "error", alt = { "FIXME", "BUG" } },
            TODO = { icon = " ", color = "info" },
            HACK = { icon = " ", color = "hack" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
            PERF = { icon = " ", color = "perf", alt = { "OPTIM" } },
            NOTE = { icon = " ", color = "hint" },
        },
        gui_style = {
            fg = "NONE",
            bg = "BOLD"
        },
        highlight = {
            before = "",
            keyword = "wide_bg",
            after = "fg",
            pattern = [[.*<(KEYWORDS)]],
            comments_only = true,
            max_line_len = 400,
            exclude = {},
        },
        colors = {
            error   = { "#f38ba8" },
            warning = { "#f9e2af" },
            hack    = { "#fab387" },
            info    = { "#89b4fa" },
            hint    = { "#a6e3a1" },
            perf    = { "#cba6f7" },
        },
        search = {
            command = "rg",
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
            },
            pattern = [[\b(KEYWORDS)]],
        },
    }

end
