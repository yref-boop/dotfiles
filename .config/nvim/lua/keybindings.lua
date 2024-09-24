local cmd = vim.cmd
local key  = vim.keymap

-- disable arrow keys
cmd('nnoremap <Left> <Nop>')
cmd('nnoremap <Down> <Nop>')
cmd('nnoremap <Up> <Nop>')
cmd('nnoremap <Right> <Nop>')
cmd('inoremap <Left> <Nop>')
cmd('inoremap <Down> <Nop>')
cmd('inoremap <Up> <Nop>')
cmd('inoremap <Right> <Nop>')

-- lsp
-- key.set()
