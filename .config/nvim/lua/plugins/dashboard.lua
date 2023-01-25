local cmd = vim.cmd

local db = require('dashboard')

db.disable_statusline = 1
db.header_pad = 1
db.center_pad = 3
db.footer_pad = 5

db.custom_header = {
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
}

db.custom_footer = { 'The best time to plant a tree was 20 years ago. The second best time is now.'}

db.custom_center= {
    {icon = '        ', desc = 'New File      ', action = 'DashboardNewFile'},
    {icon = '        ', desc = 'Last Session  ', action = 'silent source ~/.config/nvim/cache/Session.vim'},
    {icon = '        ', desc = 'Find File     ', action = 'Telescope find_files cwd=~/ hidden=true'},
    {icon = '        ', desc = 'Recent Files  ', action = 'Telescope oldfiles'},
    {icon = '        ', desc = 'File Explorer ', action = 'NvimTreeToggle'},
    {icon = '        ', desc = 'Edit Config   ', action = 'Telescope find_files cwd=~/.config hidden=true'},
}

cmd([[highlight dashboardFooter    guifg=#89ddff]])
cmd([[highlight dashboardHeader    guifg=#c3e88d]])
cmd([[highlight dashboardCenter    guifg=#82aaff]])


-- Disable statusline on dashboard
cmd([[
if has("autocmd")
    au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if &filetype == "dashboard" | set laststatus=0 noruler | else | set laststatus=2 | endif
endif
]])
