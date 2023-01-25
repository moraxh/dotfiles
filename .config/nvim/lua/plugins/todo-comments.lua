-- TODO
-- FIX
-- HACK
-- WARN
-- PERF
-- NOTE

require('todo-comments').setup{

    signs = true,
    sign_priority = 8,
    keywords = {
        FIX  = { icon = " ", color = "error", alt = { "FIXME", "BUG" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "hack" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
        PERF = { icon = " ", color = "perf", alt = { "OPTIM" } },
        NOTE = { icon = " ", color = "hint" },
    },
    merge_keywords = true,
    highlight = {
        before = "",
        keyword = "fg",
        after = "fg",
        pattern = [[.*<(KEYWORDS)]],
        comments_only = true,
        max_line_len = 400,
        exclude = {},
    },
    colors = {
        error   = { "#ff5370" },
        warning = { "#ffcb6b" },
        hack    = { "#f78c6c" },
        info    = { "#89ddff" },
        hint    = { "#c3e88d" },
        perf    = { "#c792ea" },
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

