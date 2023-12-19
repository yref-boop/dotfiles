local o = vim.opt
local c = vim.cmd

-- space as leader
vim.g.mapleader = " "

-- controls
o.mouse = ""

c("nnoremap <Left> <nop>")
c("vnoremap <Left> <nop>")
c("inoremap <Left> <nop>")

c("nnoremap <Right> <nop>")
c("vnoremap <Right> <nop>")
c("inoremap <Right> <nop>")

c("nnoremap <Down> <nop>")
c("vnoremap <Down> <nop>")
c("inoremap <Down> <nop>")

c("nnoremap <Up> <nop>")
c("vnoremap <Up> <nop>")
c("inoremap <Up> <nop>")

-- jump to next & previous diagnostics
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

