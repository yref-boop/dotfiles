o = vim.opt

o.mouse = "a"					-- allow mouse interaction in nvim
o.tabstop = 4				-- set the number of spaces in a tab to 4
o.smartindent = true			-- autoindent
o.shiftwidth = 4				-- number of spaces by indentation
o.breakindent = true			-- wrap lines mantain indentation
o.expandtab = true				-- tabs to spaces

o.clipboard = "unnamedplus"		-- allows neovim to access system clipboard
o.ignorecase = true 			-- ignore case in search patterns

vim.wo.fillchars='eob: '		-- change the ~ character to a space on non-written lines
o.showmode = false				-- do not write the mode on the bottom
o.guifont = "monospace:h15"		-- font used in graphical applications
o.termguicolors = true 			-- set terminal gui colors
