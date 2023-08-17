return function()
    require("toggleterm").setup {
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
        highlights = {
            NormalFloat = {
              link = 'Normal'
            },
            FloatBorder = {
              guifg = "#89B4FA",
            },
        },
        float_opts = { border =  'curved' },
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
        direction = 'float',
    }
end
