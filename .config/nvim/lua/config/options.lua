local o = vim.opt

-- tabs & indent
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.smartindent = true
o.breakindent = true
o.expandtab = true
o.autoindent = true


-- search & clip
o.incsearch = false
o.smartcase = true
o.iskeyword:append("-")
o.clipboard:append("unnamedplus")


-- appearance
o.number = true
o.showmode = false
o.relativenumber = true
o.termguicolors  = true
o.cmdheight = 1
o.completeopt = "menuone,noinsert,noselect"
vim.wo.fillchars ='eob: '
o.list = true
o.listchars:append "space:⋅"
o.colorcolumn = '80'

-- behaviour
o.scrolloff = 10
o.hidden = true
o.errorbells = false
o.swapfile = false
o.backup = false
o.undofile = true
o.undodir = vim.fn.expand("~/.nvim/undodir")
o.backspace = "indent,eol,start"
