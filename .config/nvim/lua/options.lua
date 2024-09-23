local vim = vim
local opt = vim.opt


-- controls
vim.g.mapleader = " "
opt.mouse = ""
vim.cmd('nnoremap <Left> <Nop>')
vim.cmd('nnoremap <Down> <Nop>')
vim.cmd('nnoremap <Up> <Nop>')
vim.cmd('nnoremap <Right> <Nop>')
vim.cmd('inoremap <Left> <Nop>')
vim.cmd('inoremap <Down> <Nop>')
vim.cmd('inoremap <Up> <Nop>')
vim.cmd('inoremap <Right> <Nop>')


-- tabs & indent
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smartindent = true
opt.breakindent = true
opt.expandtab = true
opt.autoindent = true


-- search & clip
opt.incsearch = false
opt.smartcase = true
opt.iskeyword:append("-")
opt.clipboard:append("unnamedplus")


-- appearance
opt.number = true
opt.showmode = true
opt.relativenumber = true
opt.termguicolors  = true
opt.cmdheight = 1
opt.completeopt = "menuone,noinsert,noselect"
opt.list = true
opt.colorcolumn = '80'
vim.cmd('hi Normal guibg=#00000000')
opt.laststatus = 0


-- blank indicators
opt.listchars:append "space:⋅"
vim.wo.fillchars ='eob: '
opt.guicursor = ""


-- behaviour
opt.scrolloff = 10
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.expand("~/.nvim/undodir")
opt.backspace = "indent,eol,start"
