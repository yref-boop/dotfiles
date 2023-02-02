o = vim.opt

o.mouse = "a"                   -- allow mouse interaction in nvim
o.tabstop = 4                   -- set the number of spaces in a tab to 4
o.smartindent = true            -- autoindent
o.shiftwidth = 4                -- number of spaces by indentation
o.breakindent = true            -- wrap lines mantain indentation
o.expandtab = true              -- tabs to spaces


o.clipboard = "unnamed,unnamedplus"     -- allows neovim to access system clipboard
o.ignorecase = true             -- ignore case in search patterns

vim.wo.fillchars='eob: '        -- change the ~ character to a space on non-written lines
o.showmode = false              -- do not write the mode on the bottom

o.guifont = {                   -- font used in graphical applications
    "Source Code Pro", ":h7.5:b"
}

o.termguicolors = true          -- set terminal gui colors
o.number = true                 -- show numberline
o.relativenumber = true         -- show relative numbers

-- neovide options

vim.g.neovide_transparency = 0.97
vim.g.neovide_hide_mouse_when_typing = 'true'
vim.g.neovide_cursor_trail_size = 0.25

vim.cmd("hi Normal guibg = #171617")
