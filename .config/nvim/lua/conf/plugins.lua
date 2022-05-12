
local fn = vim.fn
local packer = require("packer")
require ('lualine').setup()

-- plugins are installed here
return packer.startup(function(use)
 -- use "user/repo"
	use "wbthomason/packer.nvim"		-- packer manager itself
	use "nvim-lua/plenary.nvim"
	use "lewis6991/gitsigns.nvim"		-- git integration
	use "catppuccin/nvim"				-- catppuccin theme
	use "norcalli/nvim-colorizer.lua"	-- shows hex color values
	use "nvim-lualine/lualine.nvim"		-- bottom bar

	use 'neovim/nvim-lspconfig'			-- language diagnostics
	use 'williamboman/nvim-lsp-installer'
	--use "lervag/vimtex"				-- latex integration
end)
