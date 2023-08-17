return function()
	require("dashboard").setup({
	    theme = "doom",
	    hide = { statusline, tabline, winbar },
	    disable_move = true,
	    config = {
            header = {
                "                        ",
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
                "                        ",
            },
            center = {
                {icon = "        ", desc = "Last Session  ", key = "l", action = "silent source ~/.cache/nvim/Session.vim"},
                {icon = "        ", desc = "Recent Files  ", key = "r", action = "Telescope oldfiles"},
                {icon = "        ", desc = "Find File     ", key = "f", action = "Telescope find_files cwd=~/ hidden=true"},
                {icon = "        ", desc = "Find Text     ", key = "t", action = "Telescope live_grep"},
                {icon = "        ", desc = "File Explorer ", key = "e", action = "NvimTreeToggle"},
                {icon = "        ", desc = "Edit Config   ", key = "c", action = "Telescope find_files cwd=~/.config hidden=true"},
            },
            footer = {
                "",
                "",
                "",
                "",
                "七転び八起き"
            },
	    },
	})

	cmd([[highlight DashboardFooter     guifg=#89ddff]])
	cmd([[highlight DashboardHeader     guifg=#a6e3a1]])
	cmd([[highlight DashboardDesc       guifg=#82aaff]])
	cmd([[highlight DashboardKey        guifg=#82aaff]])
	cmd([[highlight DashboardIcon       guifg=#82aaff]])


	-- Disable statusline on dashboard
	cmd([[
        if has("autocmd")
            au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if &filetype == "dashboard" | set laststatus=0 noruler | else | set laststatus=3 | endif
        endif
	]])
end
