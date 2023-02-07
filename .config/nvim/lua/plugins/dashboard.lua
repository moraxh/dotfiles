local cmd = vim.cmd

require('dashboard').setup({
    theme = 'doom',
    hide = { statusline, tabline },
    disable_move = true,
    config = {
        header = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            " ▄▄▄██▀▀▀    ███▄ ▄███▓ ",
            "   ▒██      ▓██▒▀█▀ ██▒ ",
            "   ░██      ▓██    ▓██░ ",
            "▓██▄██▓     ▒██    ▒██  ",
            " ▓███▒      ▒██▒   ░██▒ ",
            " ▒▓▒▒░      ░ ▒░   ░  ░ ",
            " ▒ ░▒░      ░  ░      ░ ",
            " ░ ░ ░      ░      ░    ",
            " ░   ░             ░    ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        center = {
            {icon = '        ', desc = 'New File      ', action = 'DashboardNewFile'},
            {icon = '        ', desc = 'Last Session  ', action = 'silent source ~/.config/nvim/cache/Session.vim'},
            {icon = '        ', desc = 'Find File     ', action = 'Telescope find_files cwd=~/ hidden=true'},
            {icon = '        ', desc = 'Recent Files  ', action = 'Telescope oldfiles'},
            {icon = '        ', desc = 'File Explorer ', action = 'NvimTreeToggle'},
            {icon = '        ', desc = 'Edit Config   ', action = 'Telescope find_files cwd=~/.config hidden=true'},
        },
        footer = {
            "",
            "",
            "",
            "",
            "The best time to plant a tree was 20 years ago. The second best time is now."
        },
    },
})

cmd([[highlight DashboardFooter     guifg=#89ddff]])
cmd([[highlight DashboardHeader     guifg=#c3e88d]])
cmd([[highlight DashboardDesc       guifg=#82aaff]])
cmd([[highlight DashboardKey        guifg=#82aaff]])
cmd([[highlight DashboardIcon       guifg=#82aaff]])


-- Disable statusline on dashboard
cmd([[
if has("autocmd")
    au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if &filetype == "dashboard" | set laststatus=0 noruler | else | set laststatus=2 | endif
endif
]])
