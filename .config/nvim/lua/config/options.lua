local vim = vim
local opt = vim.opt

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
opt.showmode = false
opt.relativenumber = true
opt.termguicolors  = true
opt.cmdheight = 1
opt.completeopt = "menuone,noinsert,noselect"
vim.wo.fillchars ='eob: '
opt.list = true
opt.listchars:append "space:⋅"
opt.colorcolumn = '80'
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
