
local fn = vim.fn
local packer = require("packer")

-- plugins are installed here
return packer.startup(function(use)
 -- use "user/repo"	
	use "wbthomason/packer.nvim"	-- packer manager itself
	use "nvim-lua/plenary.nvim"
	use "lewis6991/gitsigns.nvim"	-- git integration
	use "catppuccin/nvim"
end)

