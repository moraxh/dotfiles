-- TODO autocomplete, goto definition etc..,

local set = vim.opt
local cmd = vim.cmd
local g = vim.g

-- Disable NonText char to " "
set.fillchars = {
    fold = ' ',
    vert = '│',
    eob = ' '
}

set.wrap 		    = false                     -- Disable line wrapping
set.ruler           = false                     -- Hide default ruler
set.showmatch 		= true			            -- Show the matching part of the pair [], {} and ()
set.showmode 		= false                     -- Hide mode
set.relativenumber 	= true                      -- Show relative number line
set.number          = true                      -- Show current number
set.cursorline		= true                      -- Highlight current line
set.mouse 		    = 'a'                       -- Enable mouse
set.termguicolors	= true                      -- Enable 24 bit color
set.clipboard 		= 'unnamedplus'             -- Enable clipboard
set.title           = true                      -- Set the filename as title
set.compatible		= false                     -- Disable compatibility to old-time vi
set.ignorecase      = true                      -- Case insensitive
set.hlsearch        = true                      -- Highlight search
set.incsearch		= true                      -- Incremental search
set.tabstop		    = 4                         -- Number of columns occupied by a tab
set.softtabstop  	= 4                         -- See multiple spaces as tabstops so <BS> does the right thing
set.expandtab		= true                      -- Converts tabs to spaces
set.smarttab        = true
set.shiftwidth		= 4                         -- Width for autoindents
set.autoindent 		= true                      -- Indent a new line the same amount as the line just typed
set.swapfile        = false                     -- Disable creating swap file
set.scrolloff       = 1                         -- When scrolling, keep cursor 1 lines away from border screen
set.sidescrolloff   = 10                        -- Keep 30 columns visible left and right of the cursor at all times
set.backspace       = 'indent,start,eol'        -- Make backspace behave like normal again
set.completeopt     = 'menu,menuone,noselect'   -- Better auto complete menu

cmd('colorscheme catppuccin')                     -- Load colorscheme
cmd('filetype plugin indent on')                -- Allow auto-indenting depending on file type
cmd('syntax on') 			                    -- Syntax highlighting

-- Vim jump to the last position when reopening a file
cmd([[
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
]])

-- Disable auto commenting new lines
cmd([[
if has("autocmd")
    au BufEnter * set fo-=c fo-=r fo-=o
endif
]])

-- Set help page in vertical split
cmd([[
if has("autocmd")
    au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if &filetype == "help" | wincmd L | endif
endif
]])

-- Delete unwanted spaces on saving
cmd([[
if has("autocmd")
    au BufWritePre * :%s/\s\+$//e
endif
]])

-- Unhighlight on save
cmd([[
if has("autocmd")
    au BufWritePre * :noh
endif
]])

-- Save Session on save
 cmd([[
 if has("autocmd")
     au BufWritePost * silent :mks! ~/.config/nvim/cache/Session.vim
 endif
 ]])
