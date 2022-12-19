local fn = vim.fn

-- install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- packer popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

vim.cmd("autocmd Colorscheme * highlight NvimTreeNormal guibg=none guifg=#9da5b3")



-- plugins
return packer.startup(function(use)
  use "wbthomason/packer.nvim"          -- have packer manage itself
  use "nvim-lua/popup.nvim"             -- an implementation of the popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"           -- useful lua functions used by lots of plugins
  use "nvim-lualine/lualine.nvim"		-- bottom bar
  use "norcalli/nvim-colorizer.lua"	    -- shows hex color values
  use "lewis6991/gitsigns.nvim"		    -- git integration
  use 'neovim/nvim-lspconfig'			-- language diagnostics
  use 'williamboman/nvim-lsp-installer' -- lsp installer
  use 'lervag/vimtex'                   -- latex
  use {'CRAG666/code_runner.nvim',      -- execute code from nvim
      requires = 'nvim-lua/plenary.nvim' 
  }
  use "nvim-telescope/telescope.nvim"   -- telescope
  use 'nvim-telescope/telescope-media-files.nvim'

    use { "kyazdani42/nvim-tree.lua"}

  use { "catppuccin/nvim", as = "catppuccin" } --catpuccin

  use({ "xiyaowong/nvim-transparent",   -- transparency 
    config = function()
      require("transparent").setup {
        enable = true,
      }
    end
  })
-- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
