local vim = vim
local opt = vim.opt
local cmd = vim.cmd

-- space as leader
vim.g.mapleader = ' '

-- ignore mouse
opt.mouse = ''

-- ignore arrows
cmd("nnoremap <Left> <nop>")
cmd("vnoremap <Left> <nop>")
cmd("inoremap <Left> <nop>")

cmd("nnoremap <Right> <nop>")
cmd("vnoremap <Right> <nop>")
cmd("inoremap <Right> <nop>")

cmd("nnoremap <Down> <nop>")
cmd("vnoremap <Down> <nop>")
cmd("inoremap <Down> <nop>")

cmd("nnoremap <Up> <nop>")
cmd("vnoremap <Up> <nop>")
cmd("inoremap <Up> <nop>")
