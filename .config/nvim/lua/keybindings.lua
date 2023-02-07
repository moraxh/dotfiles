local map = function(mode, lhs, rhs, opts)
    local options = {silent = true, noremap = true}
    if opts then options = opts end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- Telescope
map('n', '<leader>f', ':Telescope find_files cwd=~/ hidden=true<CR>')

-- Easymotion
map('n', '<leader>s', '<Plug>(easymotion-s2)', {noremap = false})

-- NvimTree
map('n', '<leader>t', ':NvimTreeToggle<CR>')

-- UndoTree
map('n', '<leader>u', ':UndotreeToggle<CR>')

--Dashboard
map('n', '<leader>q', ':SessionSave default<CR>:echo "Session Saved!"<CR>')

-- Move cursor with h,j,k,l in insert mode
map('i', '<A-h>', '<C-o>h')
map('i', '<A-j>', '<C-o>j')
map('i', '<A-k>', '<C-o>k')
map('i', '<A-l>', '<C-o>a')

-- Move b/w spilt windows
map('n', '<leader>h', ':wincmd h<CR>')
map('n', '<leader>j', ':wincmd j<CR>')
map('n', '<leader>l', ':wincmd l<CR>')
map('n', '<leader>k', ':wincmd k<CR>')

-- Insert new line without leaving normal mode
map('n', '<leader>o', 'o<Esc>0"_D')
map('n', '<leader>O', 'O<Esc>0"_D')

-- Delete words
map('n', '<leader>d', 'daw')
map('n', '<leader>c', 'caw')

-- Prevent x and the delete key from overriding what's in the clipboard.
map('v', 'x', '"_d')
map('n', 'x', '"_x')
-- Copy to the end of the line
map('n', 'Y', 'y$')

-- Keep it centered
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')

-- Save and quit bindings
map('n', '<leader>w', ':w<CR>')
map('n', '<leader>W', ':wq<CR>')
map('n', '<leader>q', ':q<CR>')
map('n', '<leader>Q', ':q!<CR>')

map('n', "<Leader>vd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map('n', "<Leader>vi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map('n', "<Leader>vsh", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map('n', "<Leader>vrr", "<cmd>lua vim.lsp.buf.references()<CR>")
map('n', "<Leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>")
map('n', "<Leader>vh", "<cmd>lua vim.lsp.buf.hover()<CR>")
map('n', "<Leader>vca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

-- Move lines
map('v', 'K', ":m '<-2<CR>gv=gv")
map('v', 'J', ":m '>+1<CR>gv=gv")
map('n', '<leader>k', ':m .-2<CR>==')
map('n', '<leader>j', ':m .+1<CR>==')

-- Exit insert mode without using <ESC>
-- map('i', 'cc', '<ESC>')

-- Move faster
map('n', '<C-j>', ':+10<CR>')
map('n', '<C-k>', ':-10<CR>')


-- Resize window
-- FIX Ctrl-r redo
-- map('n', '<C-r>', ':vertical-resize +5<CR>', { noremap = false})
map('n', '<C-l>', ':vertical-resize -5<CR>', { noremap = false })
