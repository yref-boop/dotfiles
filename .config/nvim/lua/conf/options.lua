
o = vim.opt

o.mouse = "a"					-- allow mouse interaction in nvim
o.tabstop = 4					-- set the number of spaces in a tab to 4
o.smartindent = true			-- autoindent
o.shiftwidth = 4				-- number of spaces by indentation

o.clipboard = "unnamedplus"		-- allows neovim to access system clipboard
o.ignorecase = true 			-- ignore case in search patterns

vim.wo.fillchars='eob: '		-- change the ~ character to a space on non-written lines
o.guifont = "monospace:h15"		-- font used in graphical applications

