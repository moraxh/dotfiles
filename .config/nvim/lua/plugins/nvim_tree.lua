return function()
	require("nvim-tree").setup({
	    auto_reload_on_write = true,
		update_cwd           = true,
        view = {
            cursorline = true,
        },
        renderer = {
            indent_markers = { enable = true },
            add_trailing   = true,
        }
    })

	vim.cmd([[
        if has("autocmd")
            au BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
        endif
	]])
end
