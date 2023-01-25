require('nvim-tree').setup{
    auto_reload_on_write = true,
    update_cwd = true,
    filters = {
        dotfiles = false
    },
    actions = {
    }
}

vim.cmd([[
if has("autocmd")
    au BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
endif
]])
