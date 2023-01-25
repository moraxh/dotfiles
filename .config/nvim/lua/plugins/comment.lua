require('Comment').setup{
    padding = true,     -- Add space b/w comment and the line
    ignore = '^$',      -- Dont comment empty lines
    toggler = {
        line = 'gcc',
        block = 'gb'
    }
}
